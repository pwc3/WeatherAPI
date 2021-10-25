import Foundation

public struct StationsRequest: Request {

    public typealias ResponseType = FeatureCollection<ObservationStation>

    public var officeId: String

    public var gridX: Int

    public var gridY: Int

    public init(officeId: String, gridX: Int, gridY: Int) {
        self.officeId = officeId
        self.gridX = gridX
        self.gridY = gridY
    }

    public init(for point: Feature<Point>) {
        let pt = point.properties
        self.init(
            officeId: pt.forecastOfficeId,
            gridX: pt.gridX,
            gridY: pt.gridY
        )
    }

    @available(*, deprecated)
    public init(for point: Point) {
        self.init(
            officeId: point.forecastOfficeId,
            gridX: point.gridX,
            gridY: point.gridY
        )
    }

    public func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%d,%d", gridX, gridY)
        let url = try baseURL.asURL()
            .appendingPathComponent("gridpoints")
            .appendingPathComponent(officeId)
            .appendingPathComponent(coordinate)
            .appendingPathComponent("stations")

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}
