import Foundation
import WeatherAPI
import XCTest

class ServiceTests: XCTestCase {

    private var service: Service!

    override func setUpWithError() throws {
        try super.setUpWithError()
        service = Service()
    }

    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }

    func testPoints() async throws {
        // 31 India Street, Boston, MA 02110
        let result = try await service.points(latitude: 42.358239, longitude: -71.053151)
        let point = result.properties
        print("\(String(describing: point))")
    }
}
