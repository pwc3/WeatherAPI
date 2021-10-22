import Foundation

public enum ServiceError: Error {

    case invalidResponse

    case errorStatusCode(Int)
}
