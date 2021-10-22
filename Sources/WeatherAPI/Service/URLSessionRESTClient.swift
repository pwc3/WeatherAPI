import Foundation
import os

public class URLSessionRESTClient: RESTClient {

    private let session: URLSession

    private let baseURL: URLConvertible

    private let headers: [String: String]

    private let logIncomingJSON: Bool

    public init(session: URLSession = .shared,
                baseURL: URLConvertible,
                headers: [String: String],
                logIncomingJSON: Bool = false)
    {
        self.session = session
        self.baseURL = baseURL
        self.headers = headers
        self.logIncomingJSON = logIncomingJSON
    }

    public func perform<RequestType, ResponseType>(request: RequestType) async throws -> ResponseType
    where RequestType: Request, ResponseType == RequestType.ResponseType
    {
        let urlRequest = try request.buildURLRequest(baseURL: baseURL, headers: headers)

        Log.service.debug("Requesting \(urlRequest)")
        let (data, response) = try await session.data(for: urlRequest)
        Log.service.debug("Received \(data.count) byte(s) for \(urlRequest)")

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw ServiceError.errorStatusCode(httpResponse.statusCode)
        }

        if logIncomingJSON, let string = String(data: data, encoding: .utf8) {
            Log.service.debug("Received JSON for \(urlRequest): \(string)")
        }

        return try JSONDecoder.configuredDecoder().decode(ResponseType.self, from: data)
    }
}
