//
//  ObservationStationTests.swift
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

