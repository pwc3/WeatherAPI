import Foundation

public struct FeatureCollection<PropertiesType>: Decodable
where PropertiesType: Decodable
{
    public var type: String

    public var features: [Feature<PropertiesType>]
}
