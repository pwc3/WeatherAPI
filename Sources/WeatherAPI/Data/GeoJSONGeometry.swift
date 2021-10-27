//
//  GeoJSONGeometry.swift
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
import MapKit

enum GeometryCodingKeys: CodingKey {
    case type
    case coordinates
}

public enum GeoJSONGeometry: Decodable, Equatable {
    case point(GeoJSONPoint)
    case polygon(GeoJSONPolygon)
    case unknown

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeometryCodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "Point":
            self = .point(try .init(from: decoder))

        case "Polygon":
            self = .polygon(try .init(from: decoder))

        default:
            self = .unknown
        }
    }

    public var asCLLocationCoordinate2D: CLLocationCoordinate2D? {
        guard case .point(let point) = self else {
            return nil
        }
        return point.coordinate.asCLLocationCoordinate
    }

    public var asMKMapPoint: MKMapPoint? {
        guard case .point(let point) = self else {
            return nil
        }
        return point.asMKMapPoint
    }

    public var asMKPolygon: MKPolygon? {
        guard case .polygon(let polygon) = self else {
            return nil
        }
        return polygon.asMKPolygon
    }
}

public struct Geometry<CoordinateType>: Decodable, Equatable
where CoordinateType: Decodable & Equatable
{
    internal var coordinates: CoordinateType

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeometryCodingKeys.self)
        coordinates = try container.decode(CoordinateType.self, forKey: .coordinates)
    }
}

public typealias GeoJSONPoint = Geometry<GeoJSONCoordinate>

public extension GeoJSONPoint {
    var coordinate: GeoJSONCoordinate {
        return coordinates
    }

    var asMKMapPoint: MKMapPoint {
        MKMapPoint(coordinate.asCLLocationCoordinate)
    }
}

public typealias GeoJSONPolygon = Geometry<[[GeoJSONCoordinate]]>

public extension GeoJSONPolygon {

    var points: [GeoJSONCoordinate] {
        return coordinates[0]
    }

    var asMKPolygon: MKPolygon {
        let coordinates = points.map {
            $0.asCLLocationCoordinate
        }
        return MKPolygon(coordinates: coordinates, count: coordinates.count)
    }
}

