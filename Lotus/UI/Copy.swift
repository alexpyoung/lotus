enum Copy: CustomStringConvertible {
  case hello
  case welcome
  case login
  case signup
  case logout
  case email
  case password
  case name
  case newAccount
  case existingAccount
  case workouts
  case plans
  // swiftlint:disable identifier_name
  case me
  case errorTitle
  case errorSubtitle

  var description: String {
    switch self {
    case .hello: return "Hello!"
    case .welcome: return "Welcome!"
    case .login: return "Log In"
    case .signup: return "Sign Up"
    case .logout: return "Log Out"
    case .email: return "Email"
    case .password: return "Password"
    case .name: return "Name"
    case .newAccount: return "Don't have an account? Sign up"
    case .existingAccount: return "Already have an account? Log in"
    case .workouts: return "Workouts"
    case .plans: return "Plans"
    case .me: return "Me"
    case .errorTitle: return "Oops!"
    case .errorSubtitle: return "Something went wrong..."
    }
  }
}
