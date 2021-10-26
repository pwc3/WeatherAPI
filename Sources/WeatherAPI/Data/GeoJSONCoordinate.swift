import CoreLocation
import Foundation

public struct GeoJSONCoordinate: Decodable, Equatable {

    public var latitude: Double

    public var longitude: Double

    public var asCLLocationCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(values: try container.decode([Double].self))
    }

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    init(values: [Double]) throws {
        guard values.count == 2 else {
            throw DataError.malformedInput
        }
        self.init(latitude: values[1], longitude: values[0])
    }
}
