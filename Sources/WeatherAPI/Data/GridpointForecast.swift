import Foundation

public struct GridpointForecast: Decodable {
    
    public var units: String

    public var generatedAt: String

    public var updateTime: String

    public var validTimes: String

    public var elevation: QuantitativeValue

    public var periods: [GridpointForecastPeriod]
}
