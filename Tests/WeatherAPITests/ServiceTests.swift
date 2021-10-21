import Foundation
import WeatherAPI
import XCTest

class ServiceTests: XCTestCase {

    private var service: WeatherService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        service = WeatherService()
    }

    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }

    func testPoints() async throws {
        // 31 India Street, Boston, MA 02110
        let result = try await service.points(latitude: 42.358239, longitude: -71.053151)
        let point = result.properties

        XCTAssertEqual(point.officeId, "BOX")
        XCTAssertEqual(point.forecastOfficeURL.description, "https://api.weather.gov/offices/BOX")
        XCTAssertEqual(point.gridId, "BOX")
        XCTAssertEqual(point.gridX, 71)
        XCTAssertEqual(point.gridY, 76)
        XCTAssertEqual(point.forecastURL.description, "https://api.weather.gov/gridpoints/BOX/71,76/forecast")
        XCTAssertEqual(point.forecastHourlyURL.description, "https://api.weather.gov/gridpoints/BOX/71,76/forecast/hourly")
        XCTAssertEqual(point.forecastGridDataURL.description, "https://api.weather.gov/gridpoints/BOX/71,76")
    }
}
