import Foundation

struct LatestObservationRequest: Request {

    typealias ResponseType = Feature<Observation>

    var stationId: String

    func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let url = try baseURL.asURL()
            .appendingPathComponent("stations")
            .appendingPathComponent(stationId)
            .appendingPathComponent("observations")
            .appendingPathComponent("latest")

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}

public extension WeatherService {

    func latestObservation(for station: ObservationStation) async throws -> Feature<Observation> {
        try await latestObservation(stationId: station.stationIdentifier)
    }

    func latestObservation(stationId: String) async throws -> Feature<Observation> {
        try await client.perform(request: LatestObservationRequest(stationId: stationId))
    }
}
