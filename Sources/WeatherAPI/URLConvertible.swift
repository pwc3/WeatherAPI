import Foundation

// Some utilities based on AlamoFire

protocol URLConvertible {
    func asURL() throws -> URL
}

enum URLConvertibleError: Error {
    case invalidURL(URLConvertible)
}

extension String: URLConvertible {
    func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw URLConvertibleError.invalidURL(self)
        }
        return url
    }
}

extension URL: URLConvertible {
    func asURL() throws -> URL {
        self
    }
}

enum HTTPMethod: String {
    case get
}

typealias HTTPHeaders = [String: String]

extension URLRequest {
    init(url: URLConvertible, method: HTTPMethod, headers: HTTPHeaders?) throws {
        self.init(url: try url.asURL())
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
}
