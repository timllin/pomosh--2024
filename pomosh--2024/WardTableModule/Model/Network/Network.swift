//
//  Network.swift
//  pomosh--2024
//
//  Created by Тимур Калимуллин on 23.01.2024.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private init() {
  }

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.pomosch.app/graphql")!)
}

