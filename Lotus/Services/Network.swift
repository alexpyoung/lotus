import Apollo

private struct Config: Codable {
  var apiUrl: String
  var adminSecret: String
}

final class Network {

  static let shared = Network()
  private lazy var config: Config? = {
    guard
      let path = Bundle.main.path(forResource: "Apollo", ofType: "plist"),
      let xml = FileManager.default.contents(atPath: path),
      let config = try? PropertyListDecoder().decode(Config.self, from: xml)
      else {
        return nil
    }
    return config
  }()
  private lazy var transport: NetworkTransport? = {
    guard
      let apiUrl = self.config?.apiUrl,
      let url = URL(string: apiUrl)
      else {
        return nil
    }
    let transport = HTTPNetworkTransport(url: url)
    transport.delegate = self
    return transport
  }()

  private(set) lazy var apollo: ApolloClient! = {
    guard let transport = self.transport else { return nil }
    return try? ApolloClient(transport: transport)
  }()
}

extension ApolloClient {

  convenience init(transport: NetworkTransport) throws {
    let fileURL = try FileManager.default
      .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appendingPathComponent("apollo.sqlite")
    let cache = try SQLiteNormalizedCache(fileURL: fileURL)
    self.init(networkTransport: transport, store: ApolloStore(cache: cache))
  }
}

extension Network: HTTPNetworkTransportPreflightDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
    Authentication.shared.jwt != nil
  }

  func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
    guard
      let token = Authentication.shared.jwt,
      let secret = self.config?.adminSecret
    else {
      return
    }
    var headers = request.allHTTPHeaderFields ?? [String: String]()
    headers["Authorization"] = "Bearer \(token)"
    headers["x-hasura-admin-secret"] = secret
    request.allHTTPHeaderFields = headers
  }
}
