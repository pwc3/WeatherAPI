import Foundation

public struct Observation: Decodable {

    public var timestamp: String

    public var rawMessage: String

    public var textDescription: String

    public var temperature: QuantitativeValue

    public var dewpoint: QuantitativeValue

    public var windDirection: QuantitativeValue

    public var windSpeed: QuantitativeValue

    public var windGust: QuantitativeValue

    public var barometricPressure: QuantitativeValue

    public var seaLevelPressure: QuantitativeValue

    public var visibility: QuantitativeValue

    public var maxTemperatureLast24Hours: QuantitativeValue

    public var minTemperatureLast24Hours: QuantitativeValue

    public var precipitationLastHour: QuantitativeValue

    public var precipitationLast3Hours: QuantitativeValue

    public var precipitationLast6Hours: QuantitativeValue

    public var relativeHumidity: QuantitativeValue

    public var windChill: QuantitativeValue

    public var heatIndex: QuantitativeValue

    public var cloudLayers: [CloudLayer]
}
