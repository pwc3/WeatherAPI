import Foundation
import MapKit

/**
 Wraps an `MKGeoJSONFeature` to automatically decode its associated `properties` value.
 */
public struct Feature<PropertiesType> where PropertiesType: Decodable {

    enum Error: Swift.Error {
        case missingProperties
    }

    // Keep the underlying feature private, expose its properties directly in this type.
    private let feature: MKGeoJSONFeature

    public var properties: PropertiesType

    public init(feature: MKGeoJSONFeature) throws {
        self.feature = feature

        guard let data = feature.properties else {
            throw Error.missingProperties
        }

        if let string = String(data: data, encoding: .utf8) {
            Log.service.debug("Attempting to parse \(PropertiesType.self) from JSON string: \(string)")
        }
        else {
            Log.service.error("Cannot convert properties data to UTF-8 string")
        }

        properties = try JSONDecoder().decode(PropertiesType.self, from: data)
    }

    public var geometry: [MKShape & MKGeoJSONObject] {
        feature.geometry
    }

    public var identifier: String? {
        feature.identifier
    }
}
