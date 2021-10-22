import Foundation

public final class WeatherService {

    private static let logIncomingJSON = true

    public enum Error: Swift.Error {
        case invalidResponse
        case errorStatusCode(Int)
    }

    private enum Endpoint {
        case points(latitude: Double, longitude: Double)

        case forecast(office: String, gridX: Int, gridY: Int)

        case hourlyForecast(office: String, gridX: Int, gridY: Int)

        func buildRequest(baseURL: URLConvertible, headers: [HTTPHeader]) throws -> URLRequest {
            switch self {
            case .points(let latitude, let longitude):
                let coordinate = String(format: "%0.4f,%0.4f", latitude, longitude)
                let url = try baseURL.asURL()
                    .appendingPathComponent("points")
                    .appendingPathComponent(coordinate)

                return try URLRequest(url: url, method: .get, headers: headers)

            case .forecast(let office, let gridX, let gridY):
                let coordinate = String(format: "%d,%d", gridX, gridY)
                let url = try baseURL.asURL()
                    .appendingPathComponent("gridpoints")
                    .appendingPathComponent(office)
                    .appendingPathComponent(coordinate)
                    .appendingPathComponent("forecast")

                return try URLRequest(url: url, method: .get, headers: headers)

            case .hourlyForecast(let office, let gridX, let gridY):
                let coordinate = String(format: "%d,%d", gridX, gridY)
                let url = try baseURL.asURL()
                    .appendingPathComponent("gridpoints")
                    .appendingPathComponent(office)
                    .appendingPathComponent(coordinate)
                    .appendingPathComponent("forecast")
                    .appendingPathComponent("hourly")

                return try URLRequest(url: url, method: .get, headers: headers)
            }
        }
    }

    private let session: URLSession

    private let baseURL: URLConvertible

    private let headers: [HTTPHeader] = [
        .init(name: "User-Agent", value: "(rocketinsights.com, paul@rocketinsights.com)"),
        .init(name: "Accept", value: "application/geo+json"),
    ]

    public init() {
        session = URLSession.shared
        baseURL = "https://api.weather.gov/"
    }

    private func fetchJSON<T>(from endpoint: Endpoint) async throws -> T
    where T: Decodable
    {
        let request = try endpoint.buildRequest(baseURL: baseURL, headers: headers)

        Log.service.debug("Requesting \(request)")
        let (data, response) = try await session.data(for: request)
        Log.service.debug("Received \(data.count) byte(s) for \(request)")

        guard let httpResponse = response as? HTTPURLResponse else {
            throw Error.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw Error.errorStatusCode(httpResponse.statusCode)
        }

        if Self.logIncomingJSON, let string = String(data: data, encoding: .utf8) {
            Log.service.debug("Received JSON for \(request): \(string)")
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - Endpoint functions

extension WeatherService {

    public func points(latitude: Double, longitude: Double) async throws -> Feature<Point> {
        try await fetchJSON(from: .points(latitude: latitude, longitude: longitude))
    }

    public func forecast(for point: Point) async throws -> Feature<GridpointForecast> {
        try await forecast(officeId: point.forecastOfficeId, gridX: point.gridX, gridY: point.gridY)
    }

    public func forecast(officeId: String, gridX: Int, gridY: Int) async throws -> Feature<GridpointForecast> {
        try await fetchJSON(from: .forecast(office: officeId, gridX: gridX, gridY: gridY))
    }

    public func hourlyForecast(for point: Point) async throws -> Feature<GridpointForecast> {
        try await hourlyForecast(officeId: point.forecastOfficeId, gridX: point.gridX, gridY: point.gridY)
    }

    public func hourlyForecast(officeId: String, gridX: Int, gridY: Int) async throws -> Feature<GridpointForecast> {
        try await fetchJSON(from: .hourlyForecast(office: officeId, gridX: gridX, gridY: gridY))
    }
}
