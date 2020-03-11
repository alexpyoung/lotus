import Apollo
import Auth0
import Combine
import JWTDecode
import SwiftKeychainWrapper

// swiftlint:disable identifier_name
private struct Config: Codable {
  var Domain: String
  var ClientId: String
}
// swiftlint:enable identifier_name

enum AuthenticationError: Error {
  case plistConfiguration
  case jwtPersistence
  case jwtNotFound
  case todo
}

struct Identifiers {
  let auth0Id: String
  let personId: String
}

final class Authentication {

  static let shared = Authentication()
  private(set) var jwt: String?
  private(set) var decoded: JWT?

  init() {
    guard let jwt = KeychainWrapper.standard.string(forKey: "jwt") else {
      return
    }
    self.jwt = jwt
    self.decoded = try? decode(jwt: jwt)
  }

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

  private static func createUser( email: String, password: String) -> Future<DatabaseUser, Error> {
    Future { promise in
      Auth0
        .authentication()
        .createUser(
          email: email,
          password: password,
          connection: "Username-Password-Authentication"
      )
      .start({
        switch $0 {
        case .success(let user):
          return promise(.success(user))
        case .failure(let error):
          return promise(.failure(error))
        }
      })
    }
  }

  private static func authenticate(email: String, password: String) -> Future<Credentials, Error> {
    Future { promise in
      guard let domain = config?.Domain else {
        return promise(.failure(AuthenticationError.plistConfiguration))
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
        do {
          switch $0 {
          case .success(result: let credentials):
            guard let token = credentials.idToken else {
              throw AuthenticationError.jwtPersistence
            }
            self.shared.jwt = token
            guard KeychainWrapper.standard.set(token, forKey: "jwt") else {
              throw AuthenticationError.jwtPersistence
            }
            self.shared.decoded = try decode(jwt: token)
            return promise(.success(credentials))
          case .failure(let error):
            return promise(.failure(error))
          }
        } catch let error {
          return promise(.failure(error))
        }
      })
    }
  }

  static func signUp(
    email: String,
    password: String,
    name: String
  ) -> AnyPublisher<Identifiers, Error> {
    return self.createUser(email: email, password: password)
      .flatMap { _ in self.authenticate(email: email, password: password) }
      .tryMap { (credentials: Credentials) throws -> String in
        guard
          let token = credentials.idToken,
          let jwt = try? decode(jwt: token),
          let auth0id = jwt.body["sub"] as? String
        else {
          throw AuthenticationError.todo
        }
        return auth0id
      }
    .flatMap { Network.shared.apollo.perform(mutation: SignUpMutation(auth0id: $0, name: name)) }
    .tryMap { (result: GraphQLResult<SignUpMutation.Data>) -> Identifiers in
      guard
        let personIds = result.data?.insertUsers?.returning.map({ ($0.auth0Id, $0.person.id) }),
        personIds.count == 1,
        let (auth0Id, personId) = personIds.first
      else {
        throw AuthenticationError.todo
      }
      return Identifiers(auth0Id: auth0Id, personId: personId)
    }
    .eraseToAnyPublisher()
  }

  static func logIn(email: String, password: String) -> AnyPublisher<Identifiers, Error> {
    self.authenticate(email: email, password: password)
      .tryMap { (credentials: Credentials) -> String in
        guard
          let token = credentials.idToken,
          let jwt = try? decode(jwt: token),
          let auth0id = jwt.body["sub"] as? String
        else {
          throw AuthenticationError.todo
        }
        return auth0id
      }
      .flatMap { Network.shared.apollo.fetch(query: MeQuery(auth0id: $0)) }
      .tryMap { (result: GraphQLResult<MeQuery.Data>) -> Identifiers in
        guard let (auth0Id, personId) = result.data?.users.map({ ($0.auth0Id, $0.person.id) }).first else {
          throw AuthenticationError.todo
        }
        return Identifiers(auth0Id: auth0Id, personId: personId)
      }
      .eraseToAnyPublisher()
  }
}
