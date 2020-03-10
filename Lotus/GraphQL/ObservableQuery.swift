import Apollo
import SwiftUI

protocol AuthenticatableQuery: GraphQLQuery {
  init(auth0id: String)
}

final class ObservableQuery<Query: GraphQLQuery>: ObservableObject {

  enum State {
    case loading
    case success(Query.Data)
    case error(Error)
  }

  @Published private(set) var state: State

  init(state: State = .loading) {
    self.state = state
  }

  convenience init(query: Query) {
    self.init()
    Network.shared.apollo.fetch(query: query) {
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

extension ObservableQuery where Query: AuthenticatableQuery {

  convenience init() {
    if let auth0id = Authentication.shared.decoded?.body["sub"] as? String {
      self.init(query: Query(auth0id: auth0id))
    } else {
      self.init(state: .error(AuthenticationError.jwtNotFound))
    }
  }
}

extension MyActivityPlansQuery: AuthenticatableQuery {}
extension MyActivitiesQuery: AuthenticatableQuery {}
