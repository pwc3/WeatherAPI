//
//  ISO8601Duration.swift
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

public struct ISO8601Duration: Equatable {

    public var components: DateComponents

    public var rawValue: String

    public init(rawValue: String) throws {
        self.components = try Self.parse(rawValue)
        self.rawValue = rawValue
    }

    private static func parse(_ input: String) throws -> DateComponents {
        let fullInput = NSRange(location: 0, length: input.count)
        let regex = try! NSRegularExpression(pattern:
                                             #"^P((?<years>\d+)Y)?"# +
                                             #"((?<months>\d+)M)?"# +
                                             #"((?<days>\d+)D)?"# +
                                             #"(T"# +
                                             #"((?<hours>\d+)H)?"# +
                                             #"((?<minutes>\d+)M)?"# +
                                             #"((?<seconds>\d+)S)?"# +
                                             #")?$"#, options: [])
        let matches = regex.matches(in: input, options: [], range: fullInput)

        guard matches.count == 1, let match = matches.first else {
            throw DataError.malformedInput
        }

        let segments: [(String, Calendar.Component)] = [
            ("years", .year),
            ("months", .month),
            ("days", .day),
            ("hours", .hour),
            ("minutes", .minute),
            ("seconds", .second)
        ]

        var result = DateComponents()
        for (rangeName, component) in segments {
            let matchRange = match.range(withName: rangeName)
            if matchRange.location == NSNotFound {
                continue
            }

            guard let substringRange = Range(matchRange, in: input) else {
                throw DataError.malformedInput
            }

            let stringValue = String(input[substringRange])
            guard let intValue = Int(stringValue) else {
                throw DataError.malformedInput
            }

            result.setValue(intValue, for: component)
        }

        return result
    }

    public var negatedComponents: DateComponents {
        var result = DateComponents()
        for cc: Calendar.Component in [.year, .month, .day, .hour, .minute, .second] {
            components.value(for: cc).map {
                result.setValue($0, for: cc)
            }
        }
        return result
    }
}

