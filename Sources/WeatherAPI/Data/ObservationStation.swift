import Foundation

public struct ObservationStation: Decodable, Equatable {

    public var stationIdentifier: String

    public var name: String

    public var elevation: QuantitativeValue
}
