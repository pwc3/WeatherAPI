import Foundation

public enum DataError: Error {

    case malformedInput

    case unexpectedUnit(Unit)
}
