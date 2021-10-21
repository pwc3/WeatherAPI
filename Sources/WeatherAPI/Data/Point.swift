import Foundation

public struct Point: Decodable {

    private var cwa: String

    public var forecastOfficeId: String {
        return cwa
    }

    public var gridId: String

    public var gridX: Int

    public var gridY: Int
}
