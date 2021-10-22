import Foundation

public extension URLRequest {
    init(url: URLConvertible,
         method: HTTPMethod,
         headers: [String: String]?,
         cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData)
    throws {
        self.init(url: try url.asURL(), cachePolicy: cachePolicy)
        httpMethod = method.rawValue

        headers?.forEach {
            setValue($0.value, forHTTPHeaderField: $0.key)
        }
    }
}
