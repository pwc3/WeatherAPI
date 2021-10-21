import Foundation

public struct QuantitativeValue: Decodable {

    public var value: Double?

    public var maxValue: Double?

    public var minValue: Double?

    public var unitCode: String
}
