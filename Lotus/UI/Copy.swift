enum Copy: CustomStringConvertible {
  case hello
  case welcome
  case login
  case signup
  case email
  case password
  case name
  case newAccount
  case existingAccount

  var description: String {
    switch self {
    case .hello: return "Hello!"
    case .welcome: return "Welcome!"
    case .login: return "Log In"
    case .signup: return "Sign Up"
    case .email: return "Email"
    case .password: return "Password"
    case .name: return "Name"
    case .newAccount: return "Don't have an account? Sign up"
    case .existingAccount: return "Already have an account? Log in"
    }
  }
}
