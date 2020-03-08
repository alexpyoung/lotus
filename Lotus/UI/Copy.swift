enum Copy: CustomStringConvertible {
  case login
  case signup
  case email
  case password
  case name

  var description: String {
    switch self {
    case .login: return "Log In"
    case .signup: return "Sign Up"
    case .email: return "Email"
    case .password: return "Password"
    case .name: return "Name"
    }
  }
}
