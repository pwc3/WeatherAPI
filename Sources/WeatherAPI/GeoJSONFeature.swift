import Foundation
import MapKit

public struct GeoJSONFeature<PropertiesType> where PropertiesType: Decodable {

    enum Error: Swift.Error {
        case missingProperties
    }

    public var feature: MKGeoJSONFeature

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
}
