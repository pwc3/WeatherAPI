//
//  ISO8601DurationTests.swift
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

