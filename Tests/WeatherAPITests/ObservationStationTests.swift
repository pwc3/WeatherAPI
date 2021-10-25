import Foundation
import SampleWeatherData
import WeatherAPI
import XCTest

class ObservationStationTests: XCTestCase {

    private var observationStations: [ObservationStation]!

    override func setUp() {
        super.setUp()
        observationStations = SampleData.observationStations.features.map {
            $0.properties
        }
    }

    override func tearDown() {
        observationStations = nil
        super.tearDown()
    }

    func testCount() {
        XCTAssertEqual(observationStations.count, 3)
    }

    func testStationIdentifier() {
        XCTAssertEqual(observationStations[0].stationIdentifier, "KBOS")
    }

    func testName() {
        XCTAssertEqual(observationStations[0].name, "Boston, Logan International Airport")
    }

    func testElevation() throws {
        XCTAssertEqual(try observationStations[0].elevation.length,
                       Measurement(value: 6.0960000000000001, unit: .meters))
    }
}
