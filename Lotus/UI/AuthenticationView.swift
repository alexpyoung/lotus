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
  @State var isLoading: Bool = false
  private var isEmpty: Bool {
    switch self.mode {
    case .logIn:
      return self.email.isEmpty || self.password.isEmpty
    case .signUp:
      return self.email.isEmpty || self.password.isEmpty || self.name.isEmpty
    }
  }
  private var greeting: Copy {
    switch self.mode {
    case .logIn: return .welcome
    case .signUp: return .hello
    }
  }
  var emailView: some View {
    Input(label: .email, value: self.$email, style: .plaintext)
      .autocapitalization(.none)
      .keyboardType(.emailAddress)
  }
  var passwordView: some View {
    Input(label: .password, value: self.$password, style: .secure)
  }

  private func reset(mode: AuthenticationMode) {
    self.name = ""
    self.email = ""
    self.password = ""
    self.mode = mode
  }

  var content: some View {
    switch self.mode {
    case .signUp:
      return AnyView(VStack {
        Input(label: .name, value: self.$name, style: .plaintext)
          .autocapitalization(.words)
        self.emailView
        self.passwordView
        FilledButton(title: .signup, isLoading: self.$isLoading) {
          self.isLoading = true
          Authentication.signUp(email: self.email, password: self.password, name: self.name) { result in
            self.isLoading = false
            print(result)
          }
        }
        .disabled(self.isEmpty, brightness: 0.2)
        .padding(.top, 16)
        TextButton(title: .existingAccount, style: .subheadline) { self.reset(mode: .logIn) }
          .disabled(self.isLoading, brightness: 0.2)
      })
    case .logIn:
      return AnyView(VStack {
        self.emailView
        self.passwordView
        FilledButton(title: .login, isLoading: self.$isLoading) {
          self.isLoading = true
          Authentication.logIn(email: self.email, password: self.password) { result in
            self.isLoading = false
            print(result)
          }
        }
        .disabled(self.isEmpty, brightness: 0.2)
        .padding(.top, 16)
        TextButton(title: .newAccount, style: .subheadline) { self.reset(mode: .signUp) }
          .disabled(self.isLoading, brightness: 0.2)
      })
    }
  }

  var body: some View {
    return VStack(alignment: .leading, spacing: 24) {
      Text(self.greeting)
        .font(.system(.largeTitle))
        .fontWeight(.bold)
        .foregroundColor(.offBlack)
      self.content
    }
    .padding(.vertical, 12)
    .padding(.horizontal, 24)
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
  }
}
