import Apollo

private struct Config: Codable {
  var apiUrl: String
}

class Network {

  static let shared = Network()
  private lazy var config: Config = {
    guard
      let path = Bundle.main.path(forResource: "Apollo", ofType: "plist"),
      let xml = FileManager.default.contents(atPath: path),
      let config = try? PropertyListDecoder().decode(Config.self, from: xml)
    else {
      return Config(apiUrl: "")
    }
    return config
  }()
  private(set) lazy var apollo = ApolloClient(url: URL(string: self.config.apiUrl)!)
}
