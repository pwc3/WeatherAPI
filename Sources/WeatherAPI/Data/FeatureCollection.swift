import Foundation

public struct FeatureCollection<PropertiesType>: Decodable, Equatable
where PropertiesType: Decodable & Equatable
{
    public var type: String

    public var features: [Feature<PropertiesType>]
}
