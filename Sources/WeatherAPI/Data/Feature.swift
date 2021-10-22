import Foundation

public struct Feature<PropertiesType>: Decodable, Equatable
where PropertiesType: Decodable & Equatable
{
    public var type: StringLiteralType

    public var properties: PropertiesType
}
