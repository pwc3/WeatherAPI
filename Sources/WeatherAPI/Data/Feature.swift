import Foundation
import MapKit

public struct Feature<PropertiesType>: Decodable, Equatable
where PropertiesType: Decodable & Equatable
{
    public var id: String?

    public var type: String

    public var geometry: GeoJSONGeometry

    public var properties: PropertiesType
}
