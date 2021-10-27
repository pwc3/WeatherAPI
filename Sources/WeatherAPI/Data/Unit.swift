//
//  Unit.swift
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

public struct Unit: Decodable, Equatable {

    public enum Namespace: String {
        case wmo, uc, wmoUnit, nwsUnit
    }

    public var namespace: Namespace

    public var unitName: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(string: try container.decode(String.self))
    }

    public init(string: String) throws {
        let components = string.components(separatedBy: ":")
        guard
            components.count == 2,
            let namespace = Namespace(rawValue: components[0])
        else {
            throw DataError.malformedInput
        }

        self.namespace = namespace
        unitName = components[1]
    }
}

