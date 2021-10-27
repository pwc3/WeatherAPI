//
//  URLSessionRESTClient.swift
//  WeatherAPI
//
//  Copyright (c) 2021 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

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

