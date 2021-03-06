//
//  SampleData+Point.swift
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

    static var point: Feature<Point> {
        try! decode(fromJSON: pointSource)
    }

    static let pointSource: String = """
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
    "id": "https://api.weather.gov/points/42.3581999,-71.0532",
    "type": "Feature",
    "geometry": {
        "type": "Point",
        "coordinates": [
            -71.053200000000004,
            42.358199900000002
        ]
    },
    "properties": {
        "@id": "https://api.weather.gov/points/42.3581999,-71.0532",
        "@type": "wx:Point",
        "cwa": "BOX",
        "forecastOffice": "https://api.weather.gov/offices/BOX",
        "gridId": "BOX",
        "gridX": 71,
        "gridY": 76,
        "forecast": "https://api.weather.gov/gridpoints/BOX/71,76/forecast",
        "forecastHourly": "https://api.weather.gov/gridpoints/BOX/71,76/forecast/hourly",
        "forecastGridData": "https://api.weather.gov/gridpoints/BOX/71,76",
        "observationStations": "https://api.weather.gov/gridpoints/BOX/71,76/stations",
        "relativeLocation": {
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [
                    -71.020173,
                    42.331960000000002
                ]
            },
            "properties": {
                "city": "Boston",
                "state": "MA",
                "distance": {
                    "unitCode": "wmoUnit:m",
                    "value": 3985.060317771
                },
                "bearing": {
                    "unitCode": "wmoUnit:degree_(angle)",
                    "value": 317
                }
            }
        },
        "forecastZone": "https://api.weather.gov/zones/forecast/MAZ015",
        "county": "https://api.weather.gov/zones/county/MAC025",
        "fireWeatherZone": "https://api.weather.gov/zones/fire/MAZ015",
        "timeZone": "America/New_York",
        "radarStation": "KBOX"
    }
}
"""
}

