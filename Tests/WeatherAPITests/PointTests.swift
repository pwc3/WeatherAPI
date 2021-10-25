import Foundation
import SampleWeatherData
import WeatherAPI
import XCTest

class PointTests: XCTestCase {

    private var point: Point!

    override func setUp() {
        super.setUp()
        point = SampleData.point.properties
    }

    override func tearDown() {
        point = nil
        super.tearDown()
    }

    func testForecastOfficeId() {
        XCTAssertEqual(point.forecastOfficeId, "BOX")
    }

    func testGridId() {
        XCTAssertEqual(point.gridId, "BOX")
    }

    func testGridX() {
        XCTAssertEqual(point.gridX, 71)
    }

    func testGridY() {
        XCTAssertEqual(point.gridY, 76)
    }

    func testRadarStation() {
        XCTAssertEqual(point.radarStation, "KBOX")
    }
}
