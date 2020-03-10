import Apollo
import Combine
import SwiftUI

final class ObservableQuery<Query: AuthenticatableQuery>: ObservableObject {

  let objectWillChange = PassthroughSubject<Query.Data?, Never>()
  private(set) var value: Query.Data? {
    didSet {
      DispatchQueue.main.async {
        self.objectWillChange.send(self.value)
      }
    }
  }

  init() {
    guard let auth0id = Authentication.shared.decoded?.body["sub"] as? String else {
      return
    }
    Network.shared.apollo.fetch(query: Query(auth0id: auth0id)) {
      if case let .success(result) = $0, let data = result.data {
        self.value = data
      }
    }
  }
}

protocol AuthenticatableQuery: GraphQLQuery {
  init(auth0id: String)
}

extension MyActivityPlansQuery: AuthenticatableQuery {}
