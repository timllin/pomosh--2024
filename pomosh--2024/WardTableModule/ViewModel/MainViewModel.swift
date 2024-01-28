//
//  MainViewModel.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 23.01.2024.
//

import Foundation
import Apollo
import PomochAPI
import UIKit

final class MainViewModel {
    private var wardsIds: [PomochAPI.ID]
    private(set) var wards: [Ward]
    private(set) var cachedImages: [String: UIImage]

    let isPaging: Bool
    var cursorHandler: CursorHandler?


    init(wardsIds: [PomochAPI.ID] = [PomochAPI.ID](), wards: [Ward] = [Ward](),
         isPaging: Bool = true, cursorHandler: CursorHandler? = nil) {
        self.wardsIds = wardsIds
        self.wards = wards
        self.cachedImages = [String: UIImage]()

        self.isPaging = isPaging
    }

    private func loadWardsIds(completion: @escaping ([PomochAPI.ID], Error?) -> Void) {
        Network.shared.apollo.fetch(query: WardsIdsQuery()) {result in
            switch result {
            case .success(let graphQLResult):
                if let currentIds = graphQLResult.data?.wardsIds as? [PomochAPI.ID] {
                    completion(currentIds, nil)
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    private func loadWardsById(wardsIds: [PomochAPI.ID], completion: @escaping (Bool, Error?) -> Void) {
        Network.shared.apollo.fetch(query: WardsByIdsQuery(ids: wardsIds)) {[weak self] result in
            switch result {
            case .success(let graphQLResult):
                for ward in graphQLResult.data?.wardsByIds ?? [] {

                    guard let id = ward?.id as? String,
                          let displayName = ward?.publicInformation.name.displayName as? String,
                          let photoURL = ward?.publicInformation.photo.url as? String else { continue }
                    self?.wards.append(Ward(id: id, displayName: displayName, photoURL: photoURL))
                }
                completion(true, nil)
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }

    }

    public func loadAllWards(completion: ((Bool) -> Void)? = nil) {
        loadWardsIds() {[weak self] response, error in
            guard let self = self else {return}
            self.wardsIds = response
            loadWardsById(wardsIds: Array(self.wardsIds.prefix(1))) {state, error in
                self.wards.sort {$0.getDisplayName() < $1.getDisplayName()}
                state ? completion?(true) : completion?(false)
            }
        }
    }


    public func getImageFor(ward: Ward, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = cachedImages[ward.getId()] {
            return completion(.success(image))
        }

        guard let url = URL(string: ward.gerURL()) else {return}

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.global().async() { [weak self] in
                guard let newImage = UIImage(data: data) else {return}
                self?.cachedImages[ward.getId()] = newImage
                completion(.success(newImage))
            }
        }.resume()
    }
}

// MARK: Pagination logic
extension MainViewModel {
    private func fetchCursors(completion: @escaping (Int, [String]) -> Void) {
        Network.shared.apollo.fetch(query: WardsEdgesQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                guard let totalCount = graphQLResult.data?.wards?.totalCount,
                      let edges = graphQLResult.data?.wards?.edges?.compactMap({$0.cursor}) else {return}
                completion(totalCount, edges)
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    private func fetchStartWards(completion: @escaping () -> Void) {
        guard let beforeCursor = self.cursorHandler?.beforeCursor else {return}
        Network.shared.apollo.fetch(query: WardsQuery(after: GraphQLNullable.null,
                                                      before: GraphQLNullable.init(stringLiteral: beforeCursor))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                self?.processWardsFetch(graphQLResult: graphQLResult)
                completion()
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    private func processWardsFetch(graphQLResult: GraphQLResult<WardsQuery.Data>) {
        for ward in graphQLResult.data?.wards?.nodes ?? [] {
            let id = ward.id
            let displayName = ward.publicInformation.name.displayName
            let photoURL = ward.publicInformation.photo.url
            self.wards.append(Ward(id: id, displayName: displayName, photoURL: photoURL))
        }
        let pageInfo = graphQLResult.data?.wards?.pageInfo
        self.cursorHandler?.moveCursors(pageInfo: pageInfo)
    }

    public func loadWards(completion: @escaping (Bool) -> Void) {
        fetchCursors() { [weak self] totalCount, edges in
            guard let self = self else {return}
            self.cursorHandler = CursorHandler(totalCount: totalCount, cursorsList: edges)
            self.fetchStartWards() {
                completion(true)
            }
        }
    }

    public func loadWardsWindow(completion: @escaping (Bool) -> Void) {
        guard let cursorHandler = cursorHandler else {return}

        if cursorHandler.hasNextPage && !cursorHandler.isLastPage {
            Network.shared.apollo.fetch(query: WardsQuery(after: GraphQLNullable.init(stringLiteral: cursorHandler.afterCursor),
                                                          before: GraphQLNullable.init(stringLiteral: cursorHandler.beforeCursor))) { [weak self] result in
                switch result {
                case .success(let graphQLResult):
                    self?.processWardsFetch(graphQLResult: graphQLResult)
                    completion(true)
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
        } else if cursorHandler.isLastPage {
            Network.shared.apollo.fetch(query: WardsQuery(after: GraphQLNullable.init(stringLiteral: cursorHandler.afterCursor),
                                                          before: GraphQLNullable.null)) {[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    self?.processWardsFetch(graphQLResult: graphQLResult)
                    completion(true)
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
        }
    }
}
