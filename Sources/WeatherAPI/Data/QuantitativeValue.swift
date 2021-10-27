//
//  QuantitativeValue.swift
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

public struct QuantitativeValue: Decodable, Equatable {

    public var value: Double?

    public var maxValue: Double?

    public var minValue: Double?

    public var unitCode: Unit
}

public extension QuantitativeValue {

    var length: Measurement<UnitLength>? {
        get throws {
            try asMeasurement(namespace: .wmoUnit, name: "m", unit: .meters)
        }
    }

    var temperature: Measurement<UnitTemperature>? {
        get throws {
            try asMeasurement(namespace: .wmoUnit, name: "degC", unit: .celsius)
        }
    }

    var pressure: Measurement<UnitPressure>? {
        get throws {
            // 1 N / m^2 == 1 Pa
            // See: https://en.wikipedia.org/wiki/Pascal_(unit)#Definition
            try asMeasurement(namespace: .wmoUnit, name: "Pa", unit: .newtonsPerMetersSquared)
        }
    }

    var speed: Measurement<UnitSpeed>? {
        get throws {
            try asMeasurement(namespace: .wmoUnit, name: "km_h-1", unit: .kilometersPerHour)
        }
    }

    var angle: Measurement<UnitAngle>? {
        get throws {
            try asMeasurement(namespace: .wmoUnit, name: "degree_(angle)", unit: .degrees)
        }
    }

    var percent: Double? {
        get throws {
            return try value.map { (value) throws -> Double in
                guard unitCode.namespace == .wmoUnit, unitCode.unitName == "percent" else {
                    throw DataError.unexpectedUnit(unitCode)
                }
                return value
            }
        }
    }

    private func asMeasurement<UnitType>(namespace: Unit.Namespace, name: String, unit: UnitType) throws -> Measurement<UnitType>?
    where UnitType: Foundation.Unit
    {
        return try value.map { (value) throws -> Measurement<UnitType> in
            guard
                unitCode.namespace == namespace,
                unitCode.unitName == name
            else {
                throw DataError.unexpectedUnit(unitCode)
            }

            return Measurement<UnitType>(value: value, unit: unit)
        }
    }
}

