//
//  Ward.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 25.01.2024.
//

import Foundation

struct Ward {
    private let id: String
    private let displayName: String
    private let photoURL: String

    init(id: String, displayName: String, photoURL: String) {
        self.id = id
        self.displayName = displayName
        self.photoURL = photoURL
    }

    public func getId() -> String {
        return id
    }

    public func gerURL() -> String {
        return photoURL
    }

    public func getDisplayName() -> String {
        return displayName
    }
}
