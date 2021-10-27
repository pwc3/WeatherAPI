//
//  WeatherService.swift
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

public class WeatherService {

    let client: RESTClient

    required public init(client: RESTClient) {
        self.client = client
    }

    public static var `default`: WeatherService = {
        let headers: [String: String] = [
            "User-Agent": "(rocketinsights.com, paul@rocketinsights.com)",
            "Accept": "application/geo+json"
        ]

        let baseURL = "https://api.weather.gov"

        let client = URLSessionRESTClient(baseURL: baseURL, headers: headers, logIncomingJSON: true)
        return WeatherService.init(client: client)
    }()

    public func perform<RequestType, ResponseType>(request: RequestType) async throws -> ResponseType
    where RequestType: Request, ResponseType == RequestType.ResponseType
    {
        return try await client.perform(request: request)
    }
}

