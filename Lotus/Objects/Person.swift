import SwiftUI

class Person: ObservableObject {
  // swiftlint:disable identifier_name
  @Published var id: String?
  @Published var auth0id: String?
}
