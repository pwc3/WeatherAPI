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
        let feature = try await service.points(latitude: 42.358239, longitude: -71.053151)
        let point = feature.properties

        XCTAssertEqual(point.forecastOfficeId, "BOX")
        XCTAssertEqual(point.gridId, "BOX")
        XCTAssertEqual(point.gridX, 71)
        XCTAssertEqual(point.gridY, 76)
    }

    func testForecast() async throws {
        let feature = try await service.forecast(officeId: "BOX", gridX: 71, gridY: 76)
        let _ = feature.properties
    }
}
