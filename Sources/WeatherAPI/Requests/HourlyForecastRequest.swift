import Foundation

struct HourlyForecastRequest: Request {

    typealias ResponseType = Feature<GridpointForecast>

    var officeId: String

    var gridX: Int

    var gridY: Int

    func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%d,%d", gridX, gridY)
        let url = try baseURL.asURL()
            .appendingPathComponent("gridpoints")
            .appendingPathComponent(officeId)
            .appendingPathComponent(coordinate)
            .appendingPathComponent("forecast")
            .appendingPathComponent("hourly")

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}

public extension WeatherService {

    func hourlyForecast(for point: Point) async throws -> Feature<GridpointForecast> {
        try await hourlyForecast(officeId: point.forecastOfficeId, gridX: point.gridX, gridY: point.gridY)
    }

    func hourlyForecast(officeId: String, gridX: Int, gridY: Int) async throws -> Feature<GridpointForecast> {
        try await client.perform(request: HourlyForecastRequest(officeId: officeId, gridX: gridX, gridY: gridY))
    }
}
