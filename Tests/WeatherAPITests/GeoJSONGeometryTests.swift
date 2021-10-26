import CoreLocation
import Foundation
import WeatherAPI
import XCTest

class GeoJSONGeometryTests: XCTestCase {
    func testPoint() throws {
        let source = """
 {
    "type": "Point",
    "coordinates": [
        -71.01056,
        42.36056
    ]
}
"""
        let geometry = try JSONDecoder().decode(GeoJSONGeometry.self, from: source.data(using: .utf8)!)
        guard case .point(let point) = geometry else {
            XCTFail("Incorrect type parsed")
            return
        }

        // Test the converted CLLocationCoordinate2D value
        XCTAssertEqual(point.coordinate.asCLLocationCoordinate.latitude, 42.36056)
        XCTAssertEqual(point.coordinate.asCLLocationCoordinate.longitude, -71.01056)

        // Test the raw value
        XCTAssertEqual(point.coordinate.latitude, 42.36056)
        XCTAssertEqual(point.coordinate.longitude, -71.01056)
    }

    func testPolygon() throws {
        let source = """
{
    "type": "Polygon",
    "coordinates": [
        [
            [
                -71.053381000000002,
                42.370773800000002
            ],
            [
                -71.058550699999998,
                42.34937
            ],
            [
                -71.029588699999991,
                42.3455479
            ],
            [
                -71.02441309999999,
                42.366951299999997
            ],
            [
                -71.053381000000002,
                42.370773800000002
            ]
        ]
    ]
}
"""
        let geometry = try JSONDecoder().decode(GeoJSONGeometry.self, from: source.data(using: .utf8)!)
        guard case .polygon(let polygon) = geometry else {
            XCTFail("Incorrect type parsed")
            return
        }

        XCTAssertEqual(polygon.points.count, 5)
        XCTAssertEqual(polygon.points, [
            GeoJSONCoordinate(latitude: 42.370773800000002, longitude: -71.053381000000002),
            GeoJSONCoordinate(latitude: 42.34937, longitude: -71.058550699999998),
            GeoJSONCoordinate(latitude: 42.3455479, longitude: -71.029588699999991),
            GeoJSONCoordinate(latitude: 42.366951299999997, longitude: -71.02441309999999),
            GeoJSONCoordinate(latitude: 42.370773800000002, longitude: -71.053381000000002),
        ])
    }
}
