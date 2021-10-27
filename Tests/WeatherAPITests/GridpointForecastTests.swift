//
//  GridpointForecastTests.swift
//  WeatherAPITests
//
//  Copyright (c) 2021 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import Foundation
import SampleWeatherData
@testable import WeatherAPI
import XCTest

class GridpointForecastTests: XCTestCase {

    private var forecast: GridpointForecast!

    override func setUp() {
        super.setUp()
        forecast = SampleData.sevenDayGridpointForecast.properties
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

