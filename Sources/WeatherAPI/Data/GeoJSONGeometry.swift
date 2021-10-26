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
