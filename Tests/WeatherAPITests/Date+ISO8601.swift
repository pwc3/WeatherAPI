import Foundation
import WeatherAPI

extension Date {

    static func fromISO8601(_ string: String) throws -> Date {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: string) else {
            throw DataError.malformedInput
        }
        return date
    }
}
