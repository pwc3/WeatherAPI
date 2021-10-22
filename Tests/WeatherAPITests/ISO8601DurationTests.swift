import Foundation
import WeatherAPI
import XCTest

class ISO8601DurationTests: XCTestCase {
    func testIndividualYearsParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "P1Y").components
        XCTAssertEqual(dateComponents.year, 1)
    }

    func testIndividualMonthsParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "P2M").components
        XCTAssertEqual(dateComponents.month, 2)
    }

    func testIndividualDaysParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "P3D").components
        XCTAssertEqual(dateComponents.day, 3)
    }

    func testIndividualHoursParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "PT11H").components
        XCTAssertEqual(dateComponents.hour, 11)
    }

    func testIndividualMinutesParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "PT42M").components
        XCTAssertEqual(dateComponents.minute, 42)
    }

    func testIndividualSecondsParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "PT32S").components
        XCTAssertEqual(dateComponents.second, 32)
    }

    func testFullStringParsedCorrectly() throws {
        let dateComponents = try ISO8601Duration(rawValue: "P3Y6M4DT12H30M5S").components
        XCTAssertEqual(dateComponents.year, 3)
        XCTAssertEqual(dateComponents.month, 6)
        XCTAssertEqual(dateComponents.day, 4)
        XCTAssertEqual(dateComponents.hour, 12)
        XCTAssertEqual(dateComponents.minute, 30)
        XCTAssertEqual(dateComponents.second, 5)
    }

    func testDurationStringNotStartingWithPReturnsNil() {
        XCTAssertThrowsError(try ISO8601Duration(rawValue: "3Y6M4DT12H30M5S"))
        XCTAssertThrowsError(try ISO8601Duration(rawValue: "8W"))
    }
}
