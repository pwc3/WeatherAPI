import Foundation

public struct ForecastRequest: Request {

    public typealias ResponseType = Feature<GridpointForecast>

    public var officeId: String

    public var gridX: Int

    public var gridY: Int

    public var hourly: Bool

    public init(officeId: String, gridX: Int, gridY: Int, hourly: Bool) {
        self.officeId = officeId
        self.gridX = gridX
        self.gridY = gridY
        self.hourly = hourly
    }

    public init(for point: Feature<Point>, hourly: Bool) {
        let pt = point.properties
        self.init(
            officeId: pt.forecastOfficeId,
            gridX: pt.gridX,
            gridY: pt.gridY,
            hourly: hourly
        )
    }

    public func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%d,%d", gridX, gridY)
        var url = try baseURL.asURL()
            .appendingPathComponent("gridpoints")
            .appendingPathComponent(officeId)
            .appendingPathComponent(coordinate)
            .appendingPathComponent("forecast")

        if hourly {
            url = url.appendingPathComponent("hourly")
        }

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}
