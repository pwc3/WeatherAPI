//
//  ISO8601Date.swift
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

public enum ISO8601Date: Equatable {

    case now

    case date(Date)

    public init(rawValue: String) throws {
        if rawValue == "NOW" {
            self = .now
            return
        }

        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: rawValue) else {
            throw DataError.malformedInput
        }
        self = .date(date)
    }

    public var isNow: Bool {
        switch self {
        case .now:
            return true

        case .date:
            return false
        }
    }

    public var dateValue: Date {
        switch self {
        case .now:
            return Date()

        case .date(let date):
            return date
        }
    }
}

