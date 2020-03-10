import Apollo
import SwiftUI

protocol AuthenticatableQuery: GraphQLQuery {
  init(auth0id: String)
}

final class ObservableQuery<Query: AuthenticatableQuery>: ObservableObject {

  enum State {
    case loading
    case success(Query.Data)
    case error(Error)
  }

  @Published private(set) var state: State = .loading

  init() {
    guard let auth0id = Authentication.shared.decoded?.body["sub"] as? String else {
      return
    }
    Network.shared.apollo.fetch(query: Query(auth0id: auth0id)) {
      switch $0 {
      case .success(let result):
        guard let data = result.data else {
          self.state = .error(GraphQLError([:])) // TODO
          return
        }
        self.state = .success(data)
      case .failure(let error):
        self.state = .error(error)
      }
    }
  }
}

extension MyActivityPlansQuery: AuthenticatableQuery {}
extension MyActivitiesQuery: AuthenticatableQuery {}
