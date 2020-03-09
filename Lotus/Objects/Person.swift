import SwiftUI

final class Person: ObservableObject {
  // swiftlint:disable identifier_name
  @Published var id: String?
  @Published var auth0id: String?

  init() {
    self.auth0id = Authentication.shared.decoded?.body["sub"] as? String
  }
}
