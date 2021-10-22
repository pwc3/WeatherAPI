import Foundation

struct PointsRequest: Request {

    typealias ResponseType = Feature<Point>

    var latitude: Double

    var longitude: Double

    func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%0.4f,%0.4f", latitude, longitude)
        let url = try baseURL.asURL()
            .appendingPathComponent("points")
            .appendingPathComponent(coordinate)

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}

public extension WeatherService {

    func points(latitude: Double, longitude: Double) async throws -> Feature<Point> {
        try await client.perform(request: PointsRequest(latitude: latitude, longitude: longitude))
    }
}
