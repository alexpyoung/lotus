import Auth0
import JWTDecode

// swiftlint:disable identifier_name
private struct Config: Codable {
  var Domain: String
  var ClientId: String
}
// swiftlint:enable identifier_name

enum DecodeError: Error {
  case plist
}

enum Result {
  case success(auth0id: String)
  case failure(error: Error)
}

class Authentication {

  static let shared = Authentication()
  private(set) var jwt: String?

  private static var config: Config? = {
    guard
      let path = Bundle.main.path(forResource: "Auth0", ofType: "plist"),
      let xml = FileManager.default.contents(atPath: path),
      let config = try? PropertyListDecoder().decode(Config.self, from: xml)
    else {
      return nil
    }
    return config
  }()

  private static func createUser(
    email: String,
    password: String,
    callback: @escaping (Auth0.Result<DatabaseUser>) -> Void
  ) {
    Auth0
      .authentication()
      .createUser(
        email: email,
        password: password,
        connection: "Username-Password-Authentication"
      )
      .start(callback)
  }

  private static func authenticate(
    email: String,
    password: String,
    callback: @escaping (Auth0.Result<Credentials>) -> Void
  ) {
    guard let domain = config?.Domain else {
      callback(.failure(error: DecodeError.plist))
      return
    }
    Auth0
      .authentication()
      .login(
        usernameOrEmail: email,
        password: password,
        realm: "Username-Password-Authentication",
        audience: "https://\(domain)/userinfo",
        scope: "openid profile",
        parameters: nil
      )
      .start({
        switch $0 {
        case .success(result: let credentials):
          self.shared.jwt = credentials.idToken
        case .failure: break
        }
        callback($0)
      })
  }

  static func signUp(
    email: String,
    password: String,
    name: String,
    callback: ((Result) -> Void)?
  ) {
    self.createUser(email: email, password: password) {
      switch $0 {
      case .success(let result):
        print("DEBUG:", "User created", result)
        self.authenticate(email: email, password: password) {
          switch $0 {
          case .success(let credentials):
            print("DEBUG:", "Authenticated", credentials)
            guard
              let token = credentials.idToken,
              let jwt = try? decode(jwt: token),
              let auth0id = jwt.body["sub"] as? String
              else {
                return
            }
            print("DEBUG: JWT", token)
            Network.shared.apollo.perform(mutation: SignUpMutation(auth0id: auth0id, name: name)) {
              switch $0 {
              case .success(let result):
                guard let personId = result.data?.insertUsers?.returning.map({ $0.person.id }).first else {
                  return
                }
                print("DEBUG:", "Person created", personId)
                callback?(.success(auth0id: auth0id))
              case .failure(let error):
                callback?(.failure(error: error))
              }
            }
          case .failure(error: let error):
            callback?(.failure(error: error))
          }
        }
      case .failure(let error):
        callback?(.failure(error: error))
      }
    }
  }

  static func logIn(
    email: String,
    password: String,
    callback: ((Result) -> Void)?
  ) {
    self.authenticate(email: email, password: password) {
      switch $0 {
      case .success(result: let credentials):
        guard
          let token = credentials.idToken,
          let jwt = try? decode(jwt: token),
          let auth0id = jwt.body["sub"] as? String
          else {
            return
        }
        print("DEBUG:", "Authenticated \(auth0id)")
        callback?(.success(auth0id: auth0id))
      case .failure(error: let error):
        callback?(.failure(error: error))
      }
    }
  }
}
