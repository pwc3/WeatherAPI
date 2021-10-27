//
//  ISO8601Interval.swift
//  WeatherAPI
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

public enum ISO8601Interval: Decodable, Equatable {

    case startAndEndDates(ISO8601Date, ISO8601Date)

    case startDateAndDuration(ISO8601Date, ISO8601Duration)

    case durationAndEndDate(ISO8601Duration, ISO8601Date)

    public var startDate: ISO8601Date? {
        switch self {
        case .startAndEndDates(let result, _), .startDateAndDuration(let result, _):
            return result

        case .durationAndEndDate:
            return nil
        }
    }

    public var endDate: ISO8601Date? {
        switch self {
        case .startAndEndDates(_, let result), .durationAndEndDate(_, let result):
            return result

        case .startDateAndDuration:
            return nil
        }
    }

    public var duration: ISO8601Duration? {
        switch self {
        case .startDateAndDuration(_, let result), .durationAndEndDate(let result, _):
            return result

        case .startAndEndDates:
            return nil
        }
    }
}

// MARK: - Parsing

extension ISO8601Interval {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let string = try container.decode(String.self)
        let parts = string.components(separatedBy: "/")
        guard parts.count == 2 else {
            throw DataError.malformedInput
        }

        if parts[0].starts(with: "P") || parts[0].starts(with: "T") {
            let duration = try ISO8601Duration(rawValue: parts[0])
            let endAt = try ISO8601Date(rawValue: parts[1])
            self = .durationAndEndDate(duration, endAt)
        }
        else if parts[1].starts(with: "P") || parts[0].starts(with: "T") {
            let startAt = try ISO8601Date(rawValue: parts[0])
            let duration = try ISO8601Duration(rawValue: parts[1])
            self = .startDateAndDuration(startAt, duration)
        }
        else {
            let startAt = try ISO8601Date(rawValue: parts[0])
            let endAt = try ISO8601Date(rawValue: parts[1])
            self = .startAndEndDates(startAt, endAt)
        }
    }
}

