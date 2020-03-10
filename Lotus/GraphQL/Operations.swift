// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class SignUpMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation SignUp($auth0id: String!, $name: String!) {
      insert_users(objects: {auth0_id: $auth0id, person: {data: {name: $name, groups: {data: {}}}}}) {
        __typename
        returning {
          __typename
          person {
            __typename
            id
            groups {
              __typename
              id
            }
          }
        }
      }
    }
    """

  public let operationName: String = "SignUp"

  public var auth0id: String
  public var name: String

  public init(auth0id: String, name: String) {
    self.auth0id = auth0id
    self.name = name
  }

  public var variables: GraphQLMap? {
    return ["auth0id": auth0id, "name": name]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["mutation_root"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("insert_users", arguments: ["objects": ["auth0_id": GraphQLVariable("auth0id"), "person": ["data": ["name": GraphQLVariable("name"), "groups": ["data": [:]]]]]], type: .object(InsertUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(insertUsers: InsertUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "mutation_root", "insert_users": insertUsers.flatMap { (value: InsertUser) -> ResultMap in value.resultMap }])
    }

    /// insert data into the table: "users"
    public var insertUsers: InsertUser? {
      get {
        return (resultMap["insert_users"] as? ResultMap).flatMap { InsertUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "insert_users")
      }
    }

    public struct InsertUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["users_mutation_response"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("returning", type: .nonNull(.list(.nonNull(.object(Returning.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(returning: [Returning]) {
        self.init(unsafeResultMap: ["__typename": "users_mutation_response", "returning": returning.map { (value: Returning) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// data of the affected rows by the mutation
      public var returning: [Returning] {
        get {
          return (resultMap["returning"] as! [ResultMap]).map { (value: ResultMap) -> Returning in Returning(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Returning) -> ResultMap in value.resultMap }, forKey: "returning")
        }
      }

      public struct Returning: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["users"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("person", type: .nonNull(.object(Person.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(person: Person) {
          self.init(unsafeResultMap: ["__typename": "users", "person": person.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// An object relationship
        public var person: Person {
          get {
            return Person(unsafeResultMap: resultMap["person"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "person")
          }
        }

        public struct Person: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["persons"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("groups", type: .nonNull(.list(.nonNull(.object(Group.selections))))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, groups: [Group]) {
            self.init(unsafeResultMap: ["__typename": "persons", "id": id, "groups": groups.map { (value: Group) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// An array relationship
          public var groups: [Group] {
            get {
              return (resultMap["groups"] as! [ResultMap]).map { (value: ResultMap) -> Group in Group(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Group) -> ResultMap in value.resultMap }, forKey: "groups")
            }
          }

          public struct Group: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["groups"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: String) {
              self.init(unsafeResultMap: ["__typename": "groups", "id": id])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: String {
              get {
                return resultMap["id"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }
          }
        }
      }
    }
  }
}

public final class MyActivityPlansQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query MyActivityPlans($auth0id: String!) {
      users(where: {auth0_id: {_eq: $auth0id}}) {
        __typename
        auth0_id
        person {
          __typename
          id
          groups {
            __typename
            id
            activity_plans {
              __typename
              plan {
                __typename
                id
                name
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "MyActivityPlans"

  public var auth0id: String

  public init(auth0id: String) {
    self.auth0id = auth0id
  }

  public var variables: GraphQLMap? {
    return ["auth0id": auth0id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", arguments: ["where": ["auth0_id": ["_eq": GraphQLVariable("auth0id")]]], type: .nonNull(.list(.nonNull(.object(User.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: [User]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "users": users.map { (value: User) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "users"
    public var users: [User] {
      get {
        return (resultMap["users"] as! [ResultMap]).map { (value: ResultMap) -> User in User(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: User) -> ResultMap in value.resultMap }, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["users"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("auth0_id", type: .nonNull(.scalar(String.self))),
        GraphQLField("person", type: .nonNull(.object(Person.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(auth0Id: String, person: Person) {
        self.init(unsafeResultMap: ["__typename": "users", "auth0_id": auth0Id, "person": person.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      /// An object relationship
      public var person: Person {
        get {
          return Person(unsafeResultMap: resultMap["person"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "person")
        }
      }

      public struct Person: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["persons"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("groups", type: .nonNull(.list(.nonNull(.object(Group.selections))))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: String, groups: [Group]) {
          self.init(unsafeResultMap: ["__typename": "persons", "id": id, "groups": groups.map { (value: Group) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: String {
          get {
            return resultMap["id"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// An array relationship
        public var groups: [Group] {
          get {
            return (resultMap["groups"] as! [ResultMap]).map { (value: ResultMap) -> Group in Group(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Group) -> ResultMap in value.resultMap }, forKey: "groups")
          }
        }

        public struct Group: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["groups"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("activity_plans", type: .nonNull(.list(.nonNull(.object(ActivityPlan.selections))))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: String, activityPlans: [ActivityPlan]) {
            self.init(unsafeResultMap: ["__typename": "groups", "id": id, "activity_plans": activityPlans.map { (value: ActivityPlan) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: String {
            get {
              return resultMap["id"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// An array relationship
          public var activityPlans: [ActivityPlan] {
            get {
              return (resultMap["activity_plans"] as! [ResultMap]).map { (value: ResultMap) -> ActivityPlan in ActivityPlan(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: ActivityPlan) -> ResultMap in value.resultMap }, forKey: "activity_plans")
            }
          }

          public struct ActivityPlan: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["group_activity_plans"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("plan", type: .object(Plan.selections)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(plan: Plan? = nil) {
              self.init(unsafeResultMap: ["__typename": "group_activity_plans", "plan": plan.flatMap { (value: Plan) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// An object relationship
            public var plan: Plan? {
              get {
                return (resultMap["plan"] as? ResultMap).flatMap { Plan(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "plan")
              }
            }

            public struct Plan: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["activity_plans"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: String, name: String) {
                self.init(unsafeResultMap: ["__typename": "activity_plans", "id": id, "name": name])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: String {
                get {
                  return resultMap["id"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }
            }
          }
        }
      }
    }
  }
}
