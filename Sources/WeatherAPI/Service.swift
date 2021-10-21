import Foundation
import MapKit

public final class Service {

    public enum Error: Swift.Error {
        case invalidResponse
        case errorStatusCode(Int)
    }

    private enum Endpoint: String {
        case points = "points"
    }

    private let session: URLSession

    private let baseURL: URL

    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "User-Agent": "(rocketinsights.com, paul@rocketinsights.com)",
            "Accept": "application/geo+json"
        ]
        session = URLSession(configuration: configuration)

        guard let url = URL(string: "https://api.weather.gov/") else {
            fatalError("Could not construct base URL")
        }
        baseURL = url
    }

    @available(macOS 12.0.0, *)
    public func points(latitude: Double, longitude: Double) async throws -> GeoJSONFeature<Point> {
        let request = request(for: .points, pathComponents: ["\(latitude),\(longitude)"])

        Log.service.debug("Requesting \(request)")
        let (data, response) = try await session.data(for: request)
        Log.service.debug("Received \(data.count) byte(s)")

        let jsonObjects = try geoJSON(data: data, response: response)
        guard
            jsonObjects.count == 1,
            let feature = jsonObjects.first as? MKGeoJSONFeature
        else {
            throw Error.invalidResponse
        }

        return try .init(feature: feature)
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

    private func request(for endpoint: Endpoint,
                 pathComponents: [CustomStringConvertible] = [],
                 cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy) -> URLRequest {
        var url = baseURL.appendingPathComponent(endpoint.rawValue)
        pathComponents.forEach {
            url = url.appendingPathComponent($0.description)
        }

        Log.service.debug("Created request for URL \(url)")
        return URLRequest(url: url, cachePolicy: cachePolicy)
    }
}
