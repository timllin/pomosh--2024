// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class WardsEdgesQuery: GraphQLQuery {
  public static let operationName: String = "WardsEdges"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query WardsEdges { wards { __typename edges { __typename cursor } totalCount } }"#
    ))

  public init() {}

  public struct Data: PomochAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("wards", Wards?.self),
    ] }

    /// Подопечные
    public var wards: Wards? { __data["wards"] }

    /// Wards
    ///
    /// Parent Type: `WardsConnection`
    public struct Wards: PomochAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.WardsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge]?.self),
        .field("totalCount", Int.self),
      ] }

      /// A list of edges.
      public var edges: [Edge]? { __data["edges"] }
      /// Identifies the total count of items in the connection.
      public var totalCount: Int { __data["totalCount"] }

      /// Wards.Edge
      ///
      /// Parent Type: `WardsEdge`
      public struct Edge: PomochAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.WardsEdge }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("cursor", String.self),
        ] }

        /// A cursor for use in pagination.
        public var cursor: String { __data["cursor"] }
      }
    }
  }
}
