//
//  SampleData+Observation.swift
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

    static var observation: Feature<Observation> {
        try! decode(fromJSON: observationSource)
    }

    static var observationSource: String = """
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

