import Auth0
import JWTDecode
import SwiftUI

enum AuthenticationMode {
  case signUp
  case logIn
}

struct AuthenticationView: View {

  @EnvironmentObject var person: Person

  @State var name: String = ""
  @State var email: String = ""
  @State var password: String = ""
  @State var mode: AuthenticationMode = .signUp
  @State var isLoading: Bool = false
  @State var error: Error?

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
  var errorView: some View {
    guard let error = self.error else {
      return EmptyView().any
    }
    return Text(error.localizedDescription)
      .multilineTextAlignment(.leading)
      .font(.system(.subheadline))
      .foregroundColor(.red)
      .any
  }

  private func reset(mode: AuthenticationMode) {
    self.name = ""
    self.email = ""
    self.password = ""
    self.error = nil
    self.mode = mode
  }

  private func onAuthentication(result: Result) {
    self.isLoading = false
    switch result {
    case let .success(auth0id, personId):
      DispatchQueue.main.async {
        self.person.auth0id = auth0id
        self.person.id = personId
      }
    case .failure(let error):
      self.error = error
    }
  }

  var content: some View {
    switch self.mode {
    case .signUp:
      return VStack {
        Input(label: .name, value: self.$name, style: .plaintext)
          .autocapitalization(.words)
        self.emailView
        self.passwordView
        self.errorView
        FilledButton(title: .signup, isLoading: self.$isLoading) {
          self.error = nil
          self.isLoading = true
          Authentication.signUp(
            email: self.email,
            password: self.password,
            name: self.name,
            callback: self.onAuthentication
          )
        }
        .disabled(self.isEmpty, brightness: 0.2)
        .padding(.top, 16)
        TextButton(title: .existingAccount, style: .subheadline) { self.reset(mode: .logIn) }
          .disabled(self.isLoading, brightness: 0.2)
      }.any
    case .logIn:
      return VStack {
        self.emailView
        self.passwordView
        self.errorView
        FilledButton(title: .login, isLoading: self.$isLoading) {
          self.error = nil
          self.isLoading = true
          Authentication.logIn(email: self.email, password: self.password, callback: self.onAuthentication)
        }
        .disabled(self.isEmpty, brightness: 0.2)
        .padding(.top, 16)
        TextButton(title: .newAccount, style: .subheadline) { self.reset(mode: .signUp) }
          .disabled(self.isLoading, brightness: 0.2)
      }.any
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
    .padding(.horizontal, 24)
  }
}

struct AuthenticationView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticationView()
  }
}
