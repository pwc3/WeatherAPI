import Foundation

public struct GridpointForecastPeriod: Decodable {

    public enum Error: Swift.Error {
        case invalidTemperatureUnit(String)
    }

    public var number: Int

    public var name: String

    private var startTime: String

    public var startDate: Date? {
        return ISO8601DateFormatter().date(from: startTime)
    }

    private var endTime: String

    public var endDate: Date? {
        return ISO8601DateFormatter().date(from: endTime)
    }

    public var isDaytime: Bool

    private var temperature: Int

    private var temperatureUnit: String

    private var temperatureMeasurementUnit: UnitTemperature {
        get throws {
            switch temperatureUnit {
            case "C":
                return .celsius

            case "F":
                return .fahrenheit

            default:
                throw Error.invalidTemperatureUnit(temperatureUnit)
            }
        }
    }

    public var temperatureMeasurement: Measurement<UnitTemperature> {
        get throws {
            return Measurement(value: Double(temperature), unit: try temperatureMeasurementUnit)
        }
    }

    public var temperatureTrend: String?

    public var windSpeed: String

    public var windGust: String?

    public var windDirection: String

    public var shortForecast: String

    public var detailedForecast: String

    public var icon: String
}
