import Foundation

public struct ObservationStation: Decodable {

    public var stationIdentifier: String

    public var name: String

    public var elevation: QuantitativeValue
}
