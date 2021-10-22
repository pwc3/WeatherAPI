import Foundation

public struct GridpointForecast: Decodable {

    public enum UnitType: String, Decodable {
        case us
        case si
    }
    
    public var units: UnitType

    public var generatedAt: String

    public var updateTime: String

    public var validTimes: String

    public var elevation: QuantitativeValue

    public var periods: [GridpointForecastPeriod]
}
