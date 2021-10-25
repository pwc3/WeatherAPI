import Foundation
import WeatherAPI

public class SampleData {

    static func decode<T>(fromJSON string: String) throws -> T
    where T: Decodable
    {
        guard let data = string.data(using: .utf8) else {
            throw DataError.malformedInput
        }
        return try JSONDecoder.configuredDecoder().decode(T.self, from: data)
    }
}
