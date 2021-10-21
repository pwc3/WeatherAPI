import XCTest
@testable import WeatherAPI

final class WeatherAPITests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WeatherAPI().text, "Hello, World!")
    }
}
