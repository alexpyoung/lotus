import Auth0
import JWTDecode
import SwiftUI

enum AuthenticationMode {
  case signUp
  case logIn
}

struct AuthenticationView: View {

  @State var name: String = ""
  @State var email: String = ""
  @State var password: String = ""
  @State var mode: AuthenticationMode = .signUp
  private var isEmpty: Bool {
    switch self.mode {
    case .logIn:
      return self.email.isEmpty || self.password.isEmpty
    case .signUp:
      return self.email.isEmpty || self.password.isEmpty || self.name.isEmpty
    }
  }

  private func onLoginPress() {
    Authentication.login(email: self.email, password: self.password) {
      switch $0 {
      case .success(result: let credentials):
        guard
          let token = credentials.idToken,
          let jwt = try? decode(jwt: token),
          let auth0id = jwt.body["sub"]
        else {
          return
        }
        print(auth0id)
      case .failure(error: let error):
        print(error)
      }
    }
  }

  private func onSignupPress() {
    Authentication.signup(email: self.email, password: self.password) { print($0) }
  }

  private func reset(mode: AuthenticationMode) {
    self.email = ""
    self.password = ""
    self.mode = mode
  }

  var body: some View {
    switch self.mode {
    case .signUp:
      return AnyView(VStack(alignment: .leading, spacing: 8) {
        Input(label: .name, value: self.$name, style: .plaintext)
        Input(label: .email, value: self.$email, style: .plaintext)
        Input(label: .password, value: self.$password, style: .secure)
        RoundedButton(title: .signup, style: .filled, action: self.onSignupPress)
          .disabled(self.isEmpty)
        RoundedButton(title: .login, style: .outline) { self.reset(mode: .logIn) }
      })
    case .logIn:
      return AnyView(VStack(alignment: .leading, spacing: 8) {
        Input(label: .email, value: self.$email, style: .plaintext)
        Input(label: .password, value: self.$password, style: .secure)
        RoundedButton(title: .login, style: .filled, action: self.onLoginPress)
          .disabled(self.isEmpty)
        RoundedButton(title: .signup, style: .outline) { self.reset(mode: .signUp) }
      })
    }
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
  }
}
