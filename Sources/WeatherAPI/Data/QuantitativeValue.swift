import Foundation

public struct QuantitativeValue: Decodable {

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
