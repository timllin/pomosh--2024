//
//  CursorHandler.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 25.01.2024.
//

import Foundation
import PomochAPI

final class CursorHandler {
    let limit: Int
    var offset: Int
    let totalCount: Int
    let cursorsList: [String]


    var afterCursor: String
    var beforeCursor: String
    var hasNextPage: Bool
    var hasPreviousPage: Bool
    var isLastPage: Bool

    init(limit: Int = 15, offset: Int = 0, totalCount: Int, cursorsList: [String] = [String]()) {
        self.limit = limit
        self.offset = offset
        self.totalCount = totalCount
        self.cursorsList = cursorsList

        offset == 0 ? (self.hasPreviousPage = false) : (self.hasPreviousPage = true)
        limit + offset < totalCount-1 ? (self.hasNextPage = true) : (self.hasNextPage = false)

        self.afterCursor = cursorsList[offset]
        self.beforeCursor = cursorsList[(offset+limit)%(totalCount-1)]

        self.isLastPage = false
        print(self.afterCursor, self.beforeCursor)
    }

    public func moveCursors(pageInfo: WardsQuery.Data.Wards.PageInfo?) {
        guard let pageInfo = pageInfo, let endCursor = pageInfo.endCursor else {return}
        afterCursor = endCursor
        hasPreviousPage = pageInfo.hasPreviousPage
        hasNextPage = pageInfo.hasNextPage
        offset += limit
        if offset + limit <= totalCount-1 {
            beforeCursor = cursorsList[offset + limit]
        } else {
            isLastPage = true
        }
    }
}

