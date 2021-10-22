import Foundation

public enum ISO8601Date: Equatable {

    case now

    case date(Date)

    public init(rawValue: String) throws {
        if rawValue == "NOW" {
            self = .now
            return
        }

        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: rawValue) else {
            throw DataError.malformedInput
        }
        self = .date(date)
    }

    public var isNow: Bool {
        switch self {
        case .now:
            return true

        case .date:
            return false
        }
    }

    public var dateValue: Date {
        switch self {
        case .now:
            return Date()

        case .date(let date):
            return date
        }
    }
}
