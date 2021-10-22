import Foundation
@testable import WeatherAPI
import XCTest

class ObservationTests: XCTestCase {

    private var observation: Observation!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let feature = try JSONDecoder.configuredDecoder().decode(Feature<Observation>.self, from: Self.example.data(using: .utf8)!)
        observation = feature.properties
    }

    override func tearDown() {
        observation = nil
        super.tearDown()
    }

    func testTimestamp() throws {
        XCTAssertEqual(observation.timestamp, "2021-10-22T02:54:00+00:00")
    }

    func testRawMessage() throws {
        XCTAssertEqual(observation.rawMessage, "KBOS 220254Z 21012KT 10SM SCT180 BKN220 17/14 A2985 RMK AO2 SLP109 T01720144 56010")
    }

    func testTextDescription() throws {
        XCTAssertEqual(observation.textDescription, "Mostly Cloudy")
    }

    func testTemperature() throws {
        XCTAssertEqual(try observation.temperature.temperature,
                       Measurement(value: 17.199999999999999, unit: .celsius))
    }

    func testDewpoint() throws {
        XCTAssertEqual(try observation.dewpoint.temperature,
                       Measurement(value: 14.4, unit: .celsius))
    }

    func testWindDirection() throws {
        XCTAssertEqual(try observation.windDirection.angle,
                       Measurement(value: 210, unit: .degrees))
    }

    func testWindSpeed() throws {
        XCTAssertEqual(try observation.windSpeed.speed,
                       Measurement(value: 22.32, unit: .kilometersPerHour))
    }

    func testWindGust() throws {
        XCTAssertEqual(observation.windGust, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:km_h-1")))
        XCTAssertNil(try observation.windGust.speed)
    }

    func testBarometricPressure() throws {
        XCTAssertEqual(try observation.barometricPressure.pressure,
                       Measurement(value: 101080, unit: .newtonsPerMetersSquared))
    }

    func testSeaLevelPressure() throws {
        XCTAssertEqual(try observation.seaLevelPressure.pressure,
                       Measurement(value: 101090, unit: .newtonsPerMetersSquared))
    }

    func testVisibility() throws {
        XCTAssertEqual(try observation.visibility.length,
                       Measurement(value: 16090, unit: .meters))
    }

    func testMaxTemperatureLast24Hours() throws {
        XCTAssertEqual(observation.maxTemperatureLast24Hours, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:degC")))
        XCTAssertNil(try observation.maxTemperatureLast24Hours.temperature)
    }

    func testMinTemperatureLast24Hours() throws {
        XCTAssertEqual(observation.minTemperatureLast24Hours, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:degC")))
        XCTAssertNil(try observation.minTemperatureLast24Hours.temperature)
    }

    func testPrecipitationLastHour() throws {
        XCTAssertEqual(observation.precipitationLastHour, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:m")))
        XCTAssertNil(try observation.precipitationLastHour.length)
    }

    func testPrecipitationLast3Hours() throws {
        XCTAssertEqual(observation.precipitationLast3Hours, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:m")))
        XCTAssertNil(try observation.precipitationLast3Hours.length)
    }

    func testPrecipitationLast6Hours() throws {
        XCTAssertEqual(observation.precipitationLast6Hours, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:m")))
        XCTAssertNil(try observation.precipitationLast6Hours.length)
    }

    func testRelativeHumidity() throws {
        XCTAssertEqual(try observation.relativeHumidity.percent, 83.608459924941997)
    }

    func testWindChill() throws {
        XCTAssertEqual(observation.windChill, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:degC")))
        XCTAssertNil(try observation.windChill.temperature)
    }

    func testHeatIndex() throws {
        XCTAssertEqual(observation.heatIndex, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:degC")))
        XCTAssertNil(try observation.heatIndex.temperature)
    }

    func testCloudLayers() throws {
        XCTAssertEqual(observation.cloudLayers.count, 2)
        XCTAssertEqual(observation.cloudLayers[0],
                       CloudLayer(base: QuantitativeValue(value: 5490,
                                                          unitCode: try Unit(string: "wmoUnit:m")),
                                  amount: .SCT))
        XCTAssertEqual(observation.cloudLayers[1],
                       CloudLayer(base: QuantitativeValue(value: 6710,
                                                          unitCode: try Unit(string: "wmoUnit:m")),
                                  amount: .BKN))
    }

}

extension ObservationTests {
    private static let example = """
{
    "@context": [
        "https://geojson.org/geojson-ld/geojson-context.jsonld",
        {
            "@version": "1.1",
            "wx": "https://api.weather.gov/ontology#",
            "s": "https://schema.org/",
            "geo": "http://www.opengis.net/ont/geosparql#",
            "unit": "http://codes.wmo.int/common/unit/",
            "@vocab": "https://api.weather.gov/ontology#",
            "geometry": {
                "@id": "s:GeoCoordinates",
                "@type": "geo:wktLiteral"
            },
            "city": "s:addressLocality",
            "state": "s:addressRegion",
            "distance": {
                "@id": "s:Distance",
                "@type": "s:QuantitativeValue"
            },
            "bearing": {
                "@type": "s:QuantitativeValue"
            },
            "value": {
                "@id": "s:value"
            },
            "unitCode": {
                "@id": "s:unitCode",
                "@type": "@id"
            },
            "forecastOffice": {
                "@type": "@id"
            },
            "forecastGridData": {
                "@type": "@id"
            },
            "publicZone": {
                "@type": "@id"
            },
            "county": {
                "@type": "@id"
            }
        }
    ],
    "id": "https://api.weather.gov/stations/KBOS/observations/2021-10-22T02:54:00+00:00",
    "type": "Feature",
    "geometry": {
        "type": "Point",
        "coordinates": [
            -71.030000000000001,
            42.369999999999997
        ]
    },
    "properties": {
        "@id": "https://api.weather.gov/stations/KBOS/observations/2021-10-22T02:54:00+00:00",
        "@type": "wx:ObservationStation",
        "elevation": {
            "unitCode": "wmoUnit:m",
            "value": 9
        },
        "station": "https://api.weather.gov/stations/KBOS",
        "timestamp": "2021-10-22T02:54:00+00:00",
        "rawMessage": "KBOS 220254Z 21012KT 10SM SCT180 BKN220 17/14 A2985 RMK AO2 SLP109 T01720144 56010",
        "textDescription": "Mostly Cloudy",
        "icon": "https://api.weather.gov/icons/land/night/bkn?size=medium",
        "presentWeather": [],
        "temperature": {
            "unitCode": "wmoUnit:degC",
            "value": 17.199999999999999,
            "qualityControl": "V"
        },
        "dewpoint": {
            "unitCode": "wmoUnit:degC",
            "value": 14.4,
            "qualityControl": "V"
        },
        "windDirection": {
            "unitCode": "wmoUnit:degree_(angle)",
            "value": 210,
            "qualityControl": "V"
        },
        "windSpeed": {
            "unitCode": "wmoUnit:km_h-1",
            "value": 22.32,
            "qualityControl": "V"
        },
        "windGust": {
            "unitCode": "wmoUnit:km_h-1",
            "value": null,
            "qualityControl": "Z"
        },
        "barometricPressure": {
            "unitCode": "wmoUnit:Pa",
            "value": 101080,
            "qualityControl": "V"
        },
        "seaLevelPressure": {
            "unitCode": "wmoUnit:Pa",
            "value": 101090,
            "qualityControl": "V"
        },
        "visibility": {
            "unitCode": "wmoUnit:m",
            "value": 16090,
            "qualityControl": "C"
        },
        "maxTemperatureLast24Hours": {
            "unitCode": "wmoUnit:degC",
            "value": null
        },
        "minTemperatureLast24Hours": {
            "unitCode": "wmoUnit:degC",
            "value": null
        },
        "precipitationLastHour": {
            "unitCode": "wmoUnit:m",
            "value": null,
            "qualityControl": "Z"
        },
        "precipitationLast3Hours": {
            "unitCode": "wmoUnit:m",
            "value": null,
            "qualityControl": "Z"
        },
        "precipitationLast6Hours": {
            "unitCode": "wmoUnit:m",
            "value": null,
            "qualityControl": "Z"
        },
        "relativeHumidity": {
            "unitCode": "wmoUnit:percent",
            "value": 83.608459924941997,
            "qualityControl": "V"
        },
        "windChill": {
            "unitCode": "wmoUnit:degC",
            "value": null,
            "qualityControl": "V"
        },
        "heatIndex": {
            "unitCode": "wmoUnit:degC",
            "value": null,
            "qualityControl": "V"
        },
        "cloudLayers": [
            {
                "base": {
                    "unitCode": "wmoUnit:m",
                    "value": 5490
                },
                "amount": "SCT"
            },
            {
                "base": {
                    "unitCode": "wmoUnit:m",
                    "value": 6710
                },
                "amount": "BKN"
            }
        ]
    }
}
"""
}
