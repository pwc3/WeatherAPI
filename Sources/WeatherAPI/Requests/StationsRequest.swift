import Foundation

struct StationsRequest: Request {

    typealias ResponseType = FeatureCollection<ObservationStation>

    var officeId: String

    var gridX: Int

    var gridY: Int

    func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%d,%d", gridX, gridY)
        let url = try baseURL.asURL()
            .appendingPathComponent("gridpoints")
            .appendingPathComponent(officeId)
            .appendingPathComponent(coordinate)
            .appendingPathComponent("stations")

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}

public extension WeatherService {

    func stations(for point: Point) async throws -> FeatureCollection<ObservationStation> {
        try await stations(officeId: point.forecastOfficeId, gridX: point.gridX, gridY: point.gridY)
    }

    func stations(officeId: String, gridX: Int, gridY: Int) async throws -> FeatureCollection<ObservationStation> {
        try await client.perform(request: StationsRequest(officeId: officeId, gridX: gridX, gridY: gridY))
    }
}
