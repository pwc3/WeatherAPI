//
//  StationsRequest.swift
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

public struct StationsRequest: Request {

    public typealias ResponseType = FeatureCollection<ObservationStation>

    public var officeId: String

    public var gridX: Int

    public var gridY: Int

    public init(officeId: String, gridX: Int, gridY: Int) {
        self.officeId = officeId
        self.gridX = gridX
        self.gridY = gridY
    }

    public init(for point: Feature<Point>) {
        let pt = point.properties
        self.init(
            officeId: pt.forecastOfficeId,
            gridX: pt.gridX,
            gridY: pt.gridY
        )
    }

    public func buildURLRequest(baseURL: URLConvertible, headers: [String: String]) throws -> URLRequest {
        let coordinate = String(format: "%d,%d", gridX, gridY)
        let url = try baseURL.asURL()
            .appendingPathComponent("gridpoints")
            .appendingPathComponent(officeId)
            .appendingPathComponent(coordinate)
            .appendingPathComponent("stations")

        return try URLRequest(url: url, method: .GET, headers: headers)
    }
}

