import Foundation
import MapKit

public final class WeatherService {

    public enum Error: Swift.Error {
        case invalidResponse
        case errorStatusCode(Int)
    }

    private enum Endpoint {
        case points(latitude: Double, longitude: Double)

        func buildRequest(baseURL: URLConvertible, headers: HTTPHeaders) throws -> URLRequest {
            switch self {
            case .points(let latitude, let longitude):
                let coordinate = String(format: "%.4f,%.4f", latitude, longitude)
                let url = try baseURL.asURL()
                    .appendingPathComponent("points")
                    .appendingPathComponent(coordinate)

                return try URLRequest(url: url, method: .get, headers: headers)
            }
        }
    }

    private let session: URLSession

    private let baseURL: URLConvertible

    private let headers: HTTPHeaders = [
        "User-Agent": "(rocketinsights.com, paul@rocketinsights.com)",
        "Accept": "application/geo+json"
    ]

    public init() {
        session = URLSession.shared
        baseURL = "https://api.weather.gov/"
    }

    private func fetchSingleFeature<PropertyType>(from endpoint: Endpoint) async throws -> Feature<PropertyType>
    where PropertyType: Decodable
    {
        let request = try endpoint.buildRequest(baseURL: baseURL, headers: headers)

        Log.service.debug("Requesting \(request)")
        let (data, response) = try await session.data(for: request)
        Log.service.debug("Received \(data.count) byte(s) for \(request)")

        let jsonObjects = try geoJSON(data: data, response: response)
        guard
            jsonObjects.count == 1,
            let feature = jsonObjects.first as? MKGeoJSONFeature
        else {
            Log.service.error("Invalid response received from \(request)")
            throw Error.invalidResponse
        }

        return try Feature(feature: feature)
    }

    private func geoJSON(data: Data, response: URLResponse) throws -> [MKGeoJSONObject] {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Error.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw Error.errorStatusCode(httpResponse.statusCode)
        }

        let decoder = MKGeoJSONDecoder()
        return try decoder.decode(data)
    }
}

// MARK: - Endpoint functions

extension WeatherService {

    public func points(latitude: Double, longitude: Double) async throws -> Feature<Point> {
        return try await fetchSingleFeature(from: .points(latitude: latitude, longitude: longitude))
    }
}
