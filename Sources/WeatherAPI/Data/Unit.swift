import Foundation

public struct Unit: Decodable {

    public enum Namespace: String {
        case wmo, uc, wmoUnit, nwsUnit
    }

    public var namespace: Namespace

    public var unitName: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        try self.init(string: try container.decode(String.self))
    }

    public init(string: String) throws {
        let components = string.components(separatedBy: ":")
        guard
            components.count == 2,
            let namespace = Namespace(rawValue: components[0])
        else {
            throw DataError.malformedInput
        }

        self.namespace = namespace
        unitName = components[1]
    }
}
