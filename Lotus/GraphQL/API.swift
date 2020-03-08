// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SessionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Sessions {
      sessions {
        __typename
        jwt
        auth0_id
      }
    }
    """

  public let operationName: String = "Sessions"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("sessions", type: .nonNull(.list(.nonNull(.object(Session.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(sessions: [Session]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "sessions": sessions.map { (value: Session) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "sessions"
    public var sessions: [Session] {
      get {
        return (resultMap["sessions"] as! [ResultMap]).map { (value: ResultMap) -> Session in Session(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Session) -> ResultMap in value.resultMap }, forKey: "sessions")
      }
    }

    public struct Session: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["sessions"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("jwt", type: .nonNull(.scalar(String.self))),
        GraphQLField("auth0_id", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(jwt: String, auth0Id: String) {
        self.init(unsafeResultMap: ["__typename": "sessions", "jwt": jwt, "auth0_id": auth0Id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var jwt: String {
        get {
          return resultMap["jwt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "jwt")
        }
      }

      public var auth0Id: String {
        get {
          return resultMap["auth0_id"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "auth0_id")
        }
      }
    }
  }
}
