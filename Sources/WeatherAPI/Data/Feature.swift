import Foundation

public struct Feature<PropertiesType>: Decodable
where PropertiesType: Decodable
{
    public var type: StringLiteralType

    public var properties: PropertiesType
}
