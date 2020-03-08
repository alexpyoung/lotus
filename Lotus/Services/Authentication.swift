import Auth0

// swiftlint:disable identifier_name
private struct Config: Codable {
  var Domain: String
  var ClientId: String
}
// swiftlint:enable identifier_name

enum DecodeError: Error {
  case plist
}

class Authentication {

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

  static func signup(
    email: String,
    password: String,
    callback: @escaping (Result<DatabaseUser>) -> Void
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

  static func login(
    email: String,
    password: String,
    callback: @escaping (Result<Credentials>) -> Void
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
      .start(callback)
  }
}
