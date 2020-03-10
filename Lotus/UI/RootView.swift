import SwiftUI

struct RootView: View {

  @EnvironmentObject var person: Person

  var body: some View {
    if self.person.id == nil && self.person.auth0id == nil {
      return AuthenticationView().any
    }
    return HomeView().any
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
