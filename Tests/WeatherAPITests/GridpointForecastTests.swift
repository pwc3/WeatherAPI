import Foundation
import SampleWeatherData
@testable import WeatherAPI
import XCTest

class GridpointForecastTests: XCTestCase {

    private var forecast: GridpointForecast!

    override func setUp() {
        super.setUp()
        forecast = SampleData.gridpointForecast.properties
    }

    override func tearDown() {
        forecast = nil
        super.tearDown()
    }

    func testUnits() {
        XCTAssertEqual(forecast.units, .us)
    }

    func testGeneratedAt() throws {
        XCTAssertEqual(forecast.generatedAt, try Date.fromISO8601("2021-10-22T02:18:48+00:00"))
    }

    func testUpdateTime() throws {
        XCTAssertEqual(forecast.updateTime, try Date.fromISO8601("2021-10-22T01:38:45+00:00"))
    }

    func testValidTimes() throws {
        // JSON value: "2021-10-21T19:00:00+00:00/P8DT6H"
        let expectedStartDate = try Date.fromISO8601("2021-10-21T19:00:00+00:00")
        let expectedDuration = DateComponents(day: 8, hour: 6)

        XCTAssertEqual(forecast.validTimes, .startDateAndDuration(.date(expectedStartDate), try ISO8601Duration(rawValue: "P8DT6H")))
        XCTAssertEqual(forecast.validTimes.startDate?.dateValue, expectedStartDate)
        XCTAssertNil(forecast.validTimes.endDate)
        XCTAssertEqual(forecast.validTimes.duration?.components, expectedDuration)
    }

    func testElevation() throws {
        XCTAssertEqual(try forecast.elevation.length,
                       Measurement(value: 0.91439999999999999, unit: .meters))
    }

    func testPeriods() {
        XCTAssertEqual(forecast.periods.count, 14)
        XCTAssertEqual(forecast.periods[0],
                       GridpointForecastPeriod(
                        number: 1,
                        name: "Tonight",
                        startTime: try Date.fromISO8601("2021-10-21T22:00:00-04:00"),
                        endTime: try Date.fromISO8601("2021-10-22T06:00:00-04:00"),
                        isDaytime: false,
                        temperature: 60,
                        temperatureUnit: "F",
                        temperatureTrend: nil,
                        windSpeed: "10 mph",
                        windGust: nil,
                        windDirection: .S,
                        shortForecast: "Partly Cloudy then Slight Chance Rain Showers",
                        detailedForecast: "A slight chance of rain showers after 2am. Partly cloudy, with a low around 60. South wind around 10 mph, with gusts as high as 21 mph. Chance of precipitation is 20%.",
                        icon: "https://api.weather.gov/icons/land/night/sct/rain_showers,20?size=medium"))
    }
}
