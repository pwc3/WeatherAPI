import Foundation

public struct GridpointForecast: Decodable, Equatable {

    public enum UnitType: String, Decodable, Equatable {
        case us
        case si
    }
    
    public var units: UnitType

    public var generatedAt: Date

    public var updateTime: Date

    public var validTimes: ISO8601Interval

    public var elevation: QuantitativeValue

    public var periods: [GridpointForecastPeriod]
}
