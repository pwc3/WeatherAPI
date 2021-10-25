import Foundation

public struct PointRequest: Request {

    public typealias ResponseType = Feature<Point>

    public var latitude: Double

    public var longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%0.4f,%0.4f", latitude, longitude)
        let url = try baseURL.asURL()
            .appendingPathComponent("points")
            .appendingPathComponent(coordinate)

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}
