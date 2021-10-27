//
//  ObservationTests.swift
//  WeatherAPITests
//
//  Copyright (c) 2021 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import Foundation
import SampleWeatherData
@testable import WeatherAPI
import XCTest

class ObservationTests: XCTestCase {

    private var observation: Observation!

    override func setUp() {
        super.setUp()
        observation = SampleData.observation.properties
    }

    override func tearDown() {
        observation = nil
        super.tearDown()
    }

    func testTimestamp() throws {
        XCTAssertEqual(observation.timestamp, try Date.fromISO8601("2021-10-22T02:54:00+00:00"))
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
        XCTAssertNil(try observation.precipitationLastHour?.length)
    }

    func testPrecipitationLast3Hours() throws {
        XCTAssertEqual(observation.precipitationLast3Hours, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:m")))
        XCTAssertNil(try observation.precipitationLast3Hours?.length)
    }

    func testPrecipitationLast6Hours() throws {
        XCTAssertEqual(observation.precipitationLast6Hours, QuantitativeValue(unitCode: try Unit(string: "wmoUnit:m")))
        XCTAssertNil(try observation.precipitationLast6Hours?.length)
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

    func testParseSourceWithMissingFields() throws {
        XCTAssertNoThrow(try JSONDecoder.configuredDecoder().decode(
            Feature<Observation>.self,
            from: Self.sourceWithMissingFields.data(using: .utf8)!))
    }
}

extension ObservationTests {

    private static let sourceWithMissingFields = """
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
    "id": "https://api.weather.gov/stations/D7094/observations/2021-10-24T22:45:00+00:00",
    "type": "Feature",
    "geometry": {
        "type": "Point",
        "coordinates": [
            -122.55,
            37.909999900000003
        ]
    },
    "properties": {
        "@id": "https://api.weather.gov/stations/D7094/observations/2021-10-24T22:45:00+00:00",
        "@type": "wx:ObservationStation",
        "elevation": {
            "unitCode": "wmoUnit:m",
            "value": 62.420000000000002
        },
        "station": "https://api.weather.gov/stations/D7094",
        "timestamp": "2021-10-24T22:45:00+00:00",
        "rawMessage": "",
        "textDescription": "",
        "icon": null,
        "presentWeather": [],
        "temperature": {
            "unitCode": "wmoUnit:degC",
            "value": null,
            "qualityControl": "Z"
        },
        "dewpoint": {
            "unitCode": "wmoUnit:degC",
            "value": null,
            "qualityControl": "Z"
        },
        "windDirection": {
            "unitCode": "wmoUnit:degree_(angle)",
            "value": null,
            "qualityControl": "Z"
        },
        "windSpeed": {
            "unitCode": "wmoUnit:km_h-1",
            "value": null,
            "qualityControl": "Z"
        },
        "windGust": {
            "unitCode": "wmoUnit:km_h-1",
            "value": null,
            "qualityControl": "Z"
        },
        "barometricPressure": {
            "unitCode": "wmoUnit:Pa",
            "value": null,
            "qualityControl": "Z"
        },
        "seaLevelPressure": {
            "unitCode": "wmoUnit:Pa",
            "value": null,
            "qualityControl": "Z"
        },
        "visibility": {
            "unitCode": "wmoUnit:m",
            "value": null,
            "qualityControl": "Z"
        },
        "maxTemperatureLast24Hours": {
            "unitCode": "wmoUnit:degC",
            "value": null
        },
        "minTemperatureLast24Hours": {
            "unitCode": "wmoUnit:degC",
            "value": null
        },
        "precipitationLast3Hours": {
            "unitCode": "wmoUnit:m",
            "value": null,
            "qualityControl": "Z"
        },
        "relativeHumidity": {
            "unitCode": "wmoUnit:percent",
            "value": null,
            "qualityControl": "Z"
        },
        "windChill": {
            "unitCode": "wmoUnit:degC",
            "value": null,
            "qualityControl": "Z"
        },
        "heatIndex": {
            "unitCode": "wmoUnit:degC",
            "value": null,
            "qualityControl": "Z"
        },
        "cloudLayers": []
    }
}
"""
}

