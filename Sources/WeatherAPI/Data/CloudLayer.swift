import Foundation

public struct CloudLayer: Decodable, Equatable {

    public var base: QuantitativeValue

    public var amount: MetarSkyCoverage
}
