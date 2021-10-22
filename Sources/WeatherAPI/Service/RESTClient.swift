import Foundation

public protocol RESTClient {

    func perform<RequestType, ResponseType>(request: RequestType) async throws -> ResponseType
    where RequestType: Request, ResponseType == RequestType.ResponseType
}
