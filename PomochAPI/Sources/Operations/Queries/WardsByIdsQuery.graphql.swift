// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class WardsByIdsQuery: GraphQLQuery {
  public static let operationName: String = "WardsByIds"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query WardsByIds($ids: [ID!]!) { wardsByIds(ids: $ids) { __typename id publicInformation { __typename name { __typename displayName } photo { __typename id url } } } }"#
    ))

  public var ids: [ID]

  public init(ids: [ID]) {
    self.ids = ids
  }

  public var __variables: Variables? { ["ids": ids] }

  public struct Data: PomochAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("wardsByIds", [WardsById?].self, arguments: ["ids": .variable("ids")]),
    ] }

    /// Список подопечных для указанных идентификаторов
    public var wardsByIds: [WardsById?] { __data["wardsByIds"] }

    /// WardsById
    ///
    /// Parent Type: `Ward`
    public struct WardsById: PomochAPI.SelectionSet {
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

      /// WardsById.PublicInformation
      ///
      /// Parent Type: `WardPublicInformation`
      public struct PublicInformation: PomochAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.WardPublicInformation }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("name", Name.self),
          .field("photo", Photo.self),
        ] }

        /// Имя
        public var name: Name { __data["name"] }
        /// Фотография подопечного
        public var photo: Photo { __data["photo"] }

        /// WardsById.PublicInformation.Name
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

        /// WardsById.PublicInformation.Photo
        ///
        /// Parent Type: `FileInformation`
        public struct Photo: PomochAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { PomochAPI.Objects.FileInformation }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", String.self),
            .field("url", String.self),
          ] }

          /// Идентификатор файла
          public var id: String { __data["id"] }
          /// Ссылка для отображения или скачивания файла
          public var url: String { __data["url"] }
        }
      }
    }
  }
}
