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
    private(set) var wardsIds: [PomochAPI.ID]
    private(set) var wardsByIds: [Ward]

    private(set) var cachedImages = [String: UIImage]()


    init(wardsIds: [PomochAPI.ID] = [PomochAPI.ID](), wardsByIds: [Ward] = [Ward]()) {
        self.wardsIds = wardsIds
        self.wardsByIds = wardsByIds
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
                    self?.wardsByIds.append(Ward(id: id, displayName: displayName, photoURL: photoURL))
                }
                completion(true, nil)
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }

    }

    public func loadWards(completion: ((Bool) -> Void)? = nil) {
        loadWardsIds() {[weak self] response, error in
            guard let self = self else {return}
            self.wardsIds = response
            loadWardsById(wardsIds: Array(self.wardsIds.prefix(5))) {state, error in
                self.wardsByIds.sort {$0.getDisplayName() < $1.getDisplayName()}
                state ? completion?(true) : completion?(false)
            }
        }
    }

    public func countWards() -> Int {
        return wardsByIds.count
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
