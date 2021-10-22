import Foundation

// Some utilities based on AlamoFire

public protocol URLConvertible {
    func asURL() throws -> URL
}

public enum URLConvertibleError: Error {
    case invalidURL(URLConvertible)
}

extension String: URLConvertible {
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw URLConvertibleError.invalidURL(self)
        }
        return url
    }
}

extension URL: URLConvertible {
    public func asURL() throws -> URL {
        self
    }
}
