import Foundation

public protocol Request {

    associatedtype ResponseType: Decodable

    func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest
}
