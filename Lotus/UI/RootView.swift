import SwiftUI

struct RootView: View {

  @EnvironmentObject var person: Person

  var body: some View {
    if self.person.id == nil && self.person.auth0id == nil {
      return AnyView(AuthenticationView())
    }
    return AnyView(HomeView())
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
