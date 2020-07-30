import XCTest
@testable import jsonwebtoken

final class jsonwebtokenTests: XCTestCase {
    func testBadJWT() {
        // confirm that a poorly formatted JSON token is rejected
        let possibleJWT = JWT.Parse("not.real.jwt")
        XCTAssertNil(possibleJWT)
    }

    static var allTests = [
        ("testBadJWT", testBadJWT),
    ]
}
