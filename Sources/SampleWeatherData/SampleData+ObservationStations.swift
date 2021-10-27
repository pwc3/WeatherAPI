//
//  SampleData+ObservationStations.swift
//  SampleWeatherData
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
import WeatherAPI

public extension SampleData {

    static var observationStations: FeatureCollection<ObservationStation> {
        try! decode(fromJSON: observationStationsSource)
    }

    static let observationStationsSource = """
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
            },
            "observationStations": {
                "@container": "@list",
                "@type": "@id"
            }
        }
    ],
    "type": "FeatureCollection",
    "features": [
        {
            "id": "https://api.weather.gov/stations/KBOS",
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    -71.010559999999998,
                    42.36056
                ]
            },
            "properties": {
                "@id": "https://api.weather.gov/stations/KBOS",
                "@type": "wx:ObservationStation",
                "elevation": {
                    "unitCode": "wmoUnit:m",
                    "value": 6.0960000000000001
                },
                "stationIdentifier": "KBOS",
                "name": "Boston, Logan International Airport",
                "timeZone": "America/New_York",
                "forecast": "https://api.weather.gov/zones/forecast/MAZ015",
                "county": "https://api.weather.gov/zones/county/MAC025",
                "fireWeatherZone": "https://api.weather.gov/zones/fire/MAZ015"
            }
        },
        {
            "id": "https://api.weather.gov/stations/KOWD",
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    -71.17389,
                    42.190829999999998
                ]
            },
            "properties": {
                "@id": "https://api.weather.gov/stations/KOWD",
                "@type": "wx:ObservationStation",
                "elevation": {
                    "unitCode": "wmoUnit:m",
                    "value": 14.9352
                },
                "stationIdentifier": "KOWD",
                "name": "Norwood, Norwood Memorial Airport",
                "timeZone": "America/New_York",
                "forecast": "https://api.weather.gov/zones/forecast/MAZ013",
                "county": "https://api.weather.gov/zones/county/MAC021",
                "fireWeatherZone": "https://api.weather.gov/zones/fire/MAZ013"
            }
        },
        {
            "id": "https://api.weather.gov/stations/KBED",
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    -71.294629999999998,
                    42.468110000000003
                ]
            },
            "properties": {
                "@id": "https://api.weather.gov/stations/KBED",
                "@type": "wx:ObservationStation",
                "elevation": {
                    "unitCode": "wmoUnit:m",
                    "value": 40.233600000000003
                },
                "stationIdentifier": "KBED",
                "name": "Laurence G Hanscom Field Airport",
                "timeZone": "America/New_York",
                "forecast": "https://api.weather.gov/zones/forecast/MAZ005",
                "county": "https://api.weather.gov/zones/county/MAC017",
                "fireWeatherZone": "https://api.weather.gov/zones/fire/MAZ005"
            }
        }
    ]
}
"""
}

