// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class WardsQuery: GraphQLQuery {
  public static let operationName: String = "Wards"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Wards($after: String, $before: String, $order: [WardSortInput!]) { wards(after: $after, before: $before, order: $order) { __typename totalCount pageInfo { __typename endCursor hasNextPage hasPreviousPage startCursor } edges { __typename cursor } nodes { __typename id publicInformation { __typename photo { __typename url(asAttachment: false) } name { __typename displayName } } } } }"#
    ))

  public var after: GraphQLNullable<String>
  public var before: GraphQLNullable<String>
  public var order: GraphQLNullable<[WardSortInput]>

  public init(
    after: GraphQLNullable<String>,
    before: GraphQLNullable<String>,
    order: GraphQLNullable<[WardSortInput]>
  ) {
    self.after = after
    self.before = before
    self.order = order
  }

  public var __variables: Variables? { [
    "after": after,
    "before": before,
    "order": order
  ] }

  public struct Data: PomochAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("wards", Wards?.self, arguments: [
        "after": .variable("after"),
        "before": .variable("before"),
        "order": .variable("order")
      ]),
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
        .field("totalCount", Int.self),
        .field("pageInfo", PageInfo.self),
        .field("edges", [Edge]?.self),
        .field("nodes", [Node]?.self),
      ] }

      /// Identifies the total count of items in the connection.
      public var totalCount: Int { __data["totalCount"] }
      /// Information to aid in pagination.
      public var pageInfo: PageInfo { __data["pageInfo"] }
      /// A list of edges.
      public var edges: [Edge]? { __data["edges"] }
      /// A flattened list of the nodes.
      public var nodes: [Node]? { __data["nodes"] }

      /// Wards.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: PomochAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("endCursor", String?.self),
          .field("hasNextPage", Bool.self),
          .field("hasPreviousPage", Bool.self),
          .field("startCursor", String?.self),
        ] }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? { __data["endCursor"] }
        /// Indicates whether more edges exist following the set defined by the clients arguments.
        public var hasNextPage: Bool { __data["hasNextPage"] }
        /// Indicates whether more edges exist prior the set defined by the clients arguments.
        public var hasPreviousPage: Bool { __data["hasPreviousPage"] }
        /// When paginating backwards, the cursor to continue.
        public var startCursor: String? { __data["startCursor"] }
      }

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

      /// Wards.Node
      ///
      /// Parent Type: `Ward`
      public struct Node: PomochAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.Ward }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", PomochAPI.ID.self),
          .field("publicInformation", PublicInformation.self),
        ] }

        /// Уникальный идентификатор
        public var id: PomochAPI.ID { __data["id"] }
        /// Общедоступная информация о подопечном
        public var publicInformation: PublicInformation { __data["publicInformation"] }

        /// Wards.Node.PublicInformation
        ///
        /// Parent Type: `WardPublicInformation`
        public struct PublicInformation: PomochAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.WardPublicInformation }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("photo", Photo.self),
            .field("name", Name.self),
          ] }

          /// Фотография подопечного
          public var photo: Photo { __data["photo"] }
          /// Имя
          public var name: Name { __data["name"] }

          /// Wards.Node.PublicInformation.Photo
          ///
          /// Parent Type: `FileInformation`
          public struct Photo: PomochAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.FileInformation }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("url", String.self, arguments: ["asAttachment": false]),
            ] }

            /// Ссылка для отображения или скачивания файла
            public var url: String { __data["url"] }
          }

          /// Wards.Node.PublicInformation.Name
          ///
          /// Parent Type: `Nomen`
          public struct Name: PomochAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.Nomen }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("displayName", String.self),
            ] }

            /// Имя для отображения (Имя Фамилия)
            public var displayName: String { __data["displayName"] }
          }
        }
      }
    }
  }
}
