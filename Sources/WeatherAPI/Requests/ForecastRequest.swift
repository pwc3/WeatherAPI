import Foundation

struct ForecastRequest: Request {

    typealias ResponseType = Feature<Point>

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

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}

public extension WeatherService {

    func forecast(for point: Point) async throws -> Feature<Point> {
        try await forecast(officeId: point.forecastOfficeId, gridX: point.gridX, gridY: point.gridY)
    }

    func forecast(officeId: String, gridX: Int, gridY: Int) async throws -> Feature<Point> {
        try await client.perform(request: ForecastRequest(officeId: officeId, gridX: gridX, gridY: gridY))
    }
}
