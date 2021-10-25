import Foundation

public struct LatestObservationRequest: Request {

    public typealias ResponseType = Feature<Observation>

    public var stationId: String

    public init(stationId: String) {
        self.stationId = stationId
    }

    public init(for station: Feature<ObservationStation>) {
        self.init(stationId: station.properties.stationIdentifier)
    }

    @available(*, deprecated)
    public init(for station: ObservationStation) {
        self.init(stationId: station.stationIdentifier)
    }

    public func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let url = try baseURL.asURL()
            .appendingPathComponent("stations")
            .appendingPathComponent(stationId)
            .appendingPathComponent("observations")
            .appendingPathComponent("latest")

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}
