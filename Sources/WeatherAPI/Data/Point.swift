import Foundation

public struct Point: Decodable {

    private var cwa: String

    public var officeId: String {
        return cwa
    }

    private var forecastOffice: String

    public var forecastOfficeURL: URL! {
        return URL(string: forecastOffice)
    }

    public var gridId: String

    public var gridX: Int

    public var gridY: Int

    private var forecast: String

    public var forecastURL: URL! {
        return URL(string: forecast)
    }

    private var forecastHourly: String

    public var forecastHourlyURL: URL! {
        return URL(string: forecastHourly)
    }

    private var forecastGridData: String

    public var forecastGridDataURL: URL! {
        return URL(string: forecastGridData)
    }

    public var timeZone: String
}
