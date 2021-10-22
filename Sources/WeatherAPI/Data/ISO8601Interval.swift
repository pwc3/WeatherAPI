import Foundation

public enum ISO8601Interval: Decodable, Equatable {

    case startAndEndDates(ISO8601Date, ISO8601Date)

    case startDateAndDuration(ISO8601Date, ISO8601Duration)

    case durationAndEndDate(ISO8601Duration, ISO8601Date)

    public var startDate: ISO8601Date? {
        switch self {
        case .startAndEndDates(let result, _), .startDateAndDuration(let result, _):
            return result

        case .durationAndEndDate:
            return nil
        }
    }

    public var endDate: ISO8601Date? {
        switch self {
        case .startAndEndDates(_, let result), .durationAndEndDate(_, let result):
            return result

        case .startDateAndDuration:
            return nil
        }
    }

    public var duration: ISO8601Duration? {
        switch self {
        case .startDateAndDuration(_, let result), .durationAndEndDate(let result, _):
            return result

        case .startAndEndDates:
            return nil
        }
    }
}

// MARK: - Parsing

extension ISO8601Interval {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        let string = try container.decode(String.self)
        let parts = string.components(separatedBy: "/")
        guard parts.count == 2 else {
            throw DataError.malformedInput
        }

        if parts[0].starts(with: "P") || parts[0].starts(with: "T") {
            let duration = try ISO8601Duration(rawValue: parts[0])
            let endAt = try ISO8601Date(rawValue: parts[1])
            self = .durationAndEndDate(duration, endAt)
        }
        else if parts[1].starts(with: "P") || parts[0].starts(with: "T") {
            let startAt = try ISO8601Date(rawValue: parts[0])
            let duration = try ISO8601Duration(rawValue: parts[1])
            self = .startDateAndDuration(startAt, duration)
        }
        else {
            let startAt = try ISO8601Date(rawValue: parts[0])
            let endAt = try ISO8601Date(rawValue: parts[1])
            self = .startAndEndDates(startAt, endAt)
        }
    }
}
