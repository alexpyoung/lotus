import SwiftKeychainWrapper
import SwiftUI

struct ProfileView: View {

  @EnvironmentObject var person: Person

  var body: some View {
    VStack {
      FilledButton(title: .logout, isLoading: .constant(false)) {
        KeychainWrapper.standard.removeObject(forKey: "jwt")
        DispatchQueue.main.async {
          self.person.auth0id = nil
        }
      }
    }
    .padding(.horizontal, 24)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
