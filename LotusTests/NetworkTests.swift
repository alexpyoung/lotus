import XCTest
@testable import Lotus

class NetworkTests: XCTestCase {

  func testClient() {
    let client = Network.shared.apollo
    XCTAssertNotNil(client)
  }
}
