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

struct HTTPHeader {
    var name: String
    var value: String
}

extension URLRequest {
    init(url: URLConvertible,
         method: HTTPMethod,
         headers: [HTTPHeader]?,
         cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData)
    throws {
        self.init(url: try url.asURL(), cachePolicy: cachePolicy)
        httpMethod = method.rawValue

        headers?.forEach {
            setValue($0.value, forHTTPHeaderField: $0.name)
        }
    }
}
