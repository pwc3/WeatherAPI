import Foundation

public struct GridpointForecastPeriod: Decodable {

    public enum TemperatureTrend: String, Decodable {
        case rising, falling
    }

    public enum WindDirection: String, Decodable {
        case N, NNE, NE, ENE, E, ESE, SE, SSE, S, SSW, SW, WSW, W, WNW, NW, NNW
    }

    public var number: Int

    public var name: String

    public var startTime: String

    public var endTime: String

    public var isDaytime: Bool

    public var temperature: Int

    public var temperatureUnit: String

    public var temperatureTrend: TemperatureTrend?

    public var windSpeed: String

    public var windGust: String?

    public var windDirection: WindDirection

    public var shortForecast: String

    public var detailedForecast: String

    public var icon: String
}
