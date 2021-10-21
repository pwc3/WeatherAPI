import Foundation
import os

struct Log {

    private static let subsystem = "com.rocketinsights.WeatherAPI"

    static let service = Logger(subsystem: subsystem, category: "service")
}
