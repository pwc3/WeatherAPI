import Foundation
import WeatherAPI

public extension SampleData {

    static var sevenDayGridpointForecast: Feature<GridpointForecast> {
        try! decode(fromJSON: sevenDayGridpointForecastSource)
    }

    static let sevenDayGridpointForecastSource = """
{
    "@context": [
        "https://geojson.org/geojson-ld/geojson-context.jsonld",
        {
            "@version": "1.1",
            "wx": "https://api.weather.gov/ontology#",
            "geo": "http://www.opengis.net/ont/geosparql#",
            "unit": "http://codes.wmo.int/common/unit/",
            "@vocab": "https://api.weather.gov/ontology#"
        }
    ],
    "type": "Feature",
    "geometry": {
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
    },
    "properties": {
        "updated": "2021-10-22T01:38:45+00:00",
        "units": "us",
        "forecastGenerator": "BaselineForecastGenerator",
        "generatedAt": "2021-10-22T02:18:48+00:00",
        "updateTime": "2021-10-22T01:38:45+00:00",
        "validTimes": "2021-10-21T19:00:00+00:00/P8DT6H",
        "elevation": {
            "unitCode": "wmoUnit:m",
            "value": 0.91439999999999999
        },
        "periods": [
            {
                "number": 1,
                "name": "Tonight",
                "startTime": "2021-10-21T22:00:00-04:00",
                "endTime": "2021-10-22T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 60,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "10 mph",
                "windDirection": "S",
                "icon": "https://api.weather.gov/icons/land/night/sct/rain_showers,20?size=medium",
                "shortForecast": "Partly Cloudy then Slight Chance Rain Showers",
                "detailedForecast": "A slight chance of rain showers after 2am. Partly cloudy, with a low around 60. South wind around 10 mph, with gusts as high as 21 mph. Chance of precipitation is 20%."
            },
            {
                "number": 2,
                "name": "Friday",
                "startTime": "2021-10-22T06:00:00-04:00",
                "endTime": "2021-10-22T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 72,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "12 mph",
                "windDirection": "SW",
                "icon": "https://api.weather.gov/icons/land/day/rain_showers,20/sct?size=medium",
                "shortForecast": "Slight Chance Rain Showers then Mostly Sunny",
                "detailedForecast": "A slight chance of rain showers before 8am. Mostly sunny, with a high near 72. Southwest wind around 12 mph. Chance of precipitation is 20%."
            },
            {
                "number": 3,
                "name": "Friday Night",
                "startTime": "2021-10-22T18:00:00-04:00",
                "endTime": "2021-10-23T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 54,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "8 mph",
                "windDirection": "NW",
                "icon": "https://api.weather.gov/icons/land/night/bkn?size=medium",
                "shortForecast": "Mostly Cloudy",
                "detailedForecast": "Mostly cloudy, with a low around 54. Northwest wind around 8 mph."
            },
            {
                "number": 4,
                "name": "Saturday",
                "startTime": "2021-10-23T06:00:00-04:00",
                "endTime": "2021-10-23T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 61,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "8 mph",
                "windDirection": "NW",
                "icon": "https://api.weather.gov/icons/land/day/rain_showers,20/rain_showers,40?size=medium",
                "shortForecast": "Chance Rain Showers",
                "detailedForecast": "A chance of rain showers after 7am. Mostly cloudy, with a high near 61. Northwest wind around 8 mph. Chance of precipitation is 40%."
            },
            {
                "number": 5,
                "name": "Saturday Night",
                "startTime": "2021-10-23T18:00:00-04:00",
                "endTime": "2021-10-24T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 47,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "8 mph",
                "windDirection": "NW",
                "icon": "https://api.weather.gov/icons/land/night/rain_showers,30/sct?size=medium",
                "shortForecast": "Chance Rain Showers then Partly Cloudy",
                "detailedForecast": "A chance of rain showers before 7pm. Partly cloudy, with a low around 47. Northwest wind around 8 mph. Chance of precipitation is 30%."
            },
            {
                "number": 6,
                "name": "Sunday",
                "startTime": "2021-10-24T06:00:00-04:00",
                "endTime": "2021-10-24T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 62,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "10 mph",
                "windDirection": "W",
                "icon": "https://api.weather.gov/icons/land/day/sct?size=medium",
                "shortForecast": "Mostly Sunny",
                "detailedForecast": "Mostly sunny, with a high near 62. West wind around 10 mph."
            },
            {
                "number": 7,
                "name": "Sunday Night",
                "startTime": "2021-10-24T18:00:00-04:00",
                "endTime": "2021-10-25T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 47,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "9 mph",
                "windDirection": "NW",
                "icon": "https://api.weather.gov/icons/land/night/sct?size=medium",
                "shortForecast": "Partly Cloudy",
                "detailedForecast": "Partly cloudy, with a low around 47. Northwest wind around 9 mph."
            },
            {
                "number": 8,
                "name": "Monday",
                "startTime": "2021-10-25T06:00:00-04:00",
                "endTime": "2021-10-25T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 58,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "7 to 10 mph",
                "windDirection": "N",
                "icon": "https://api.weather.gov/icons/land/day/bkn?size=medium",
                "shortForecast": "Partly Sunny",
                "detailedForecast": "Partly sunny, with a high near 58. North wind 7 to 10 mph."
            },
            {
                "number": 9,
                "name": "Monday Night",
                "startTime": "2021-10-25T18:00:00-04:00",
                "endTime": "2021-10-26T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 48,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "8 mph",
                "windDirection": "NE",
                "icon": "https://api.weather.gov/icons/land/night/rain_showers?size=medium",
                "shortForecast": "Slight Chance Rain Showers",
                "detailedForecast": "A slight chance of rain showers between 8pm and 4am. Mostly cloudy, with a low around 48. Northeast wind around 8 mph."
            },
            {
                "number": 10,
                "name": "Tuesday",
                "startTime": "2021-10-26T06:00:00-04:00",
                "endTime": "2021-10-26T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 57,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "9 to 13 mph",
                "windDirection": "NE",
                "icon": "https://api.weather.gov/icons/land/day/rain_showers?size=medium",
                "shortForecast": "Slight Chance Rain Showers",
                "detailedForecast": "A slight chance of rain showers before 3pm. Mostly cloudy, with a high near 57. Northeast wind 9 to 13 mph."
            },
            {
                "number": 11,
                "name": "Tuesday Night",
                "startTime": "2021-10-26T18:00:00-04:00",
                "endTime": "2021-10-27T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 49,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "13 mph",
                "windDirection": "NE",
                "icon": "https://api.weather.gov/icons/land/night/rain_showers?size=medium",
                "shortForecast": "Slight Chance Rain Showers",
                "detailedForecast": "A slight chance of rain showers between 8pm and 3am. Mostly cloudy, with a low around 49. Northeast wind around 13 mph."
            },
            {
                "number": 12,
                "name": "Wednesday",
                "startTime": "2021-10-27T06:00:00-04:00",
                "endTime": "2021-10-27T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 58,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "14 mph",
                "windDirection": "NE",
                "icon": "https://api.weather.gov/icons/land/day/rain_showers?size=medium",
                "shortForecast": "Slight Chance Rain Showers",
                "detailedForecast": "A slight chance of rain showers between 8am and 4pm. Mostly cloudy, with a high near 58. Northeast wind around 14 mph."
            },
            {
                "number": 13,
                "name": "Wednesday Night",
                "startTime": "2021-10-27T18:00:00-04:00",
                "endTime": "2021-10-28T06:00:00-04:00",
                "isDaytime": false,
                "temperature": 52,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "13 mph",
                "windDirection": "NE",
                "icon": "https://api.weather.gov/icons/land/night/rain_showers?size=medium",
                "shortForecast": "Slight Chance Rain Showers",
                "detailedForecast": "A slight chance of rain showers between 8pm and 5am. Mostly cloudy, with a low around 52. Northeast wind around 13 mph."
            },
            {
                "number": 14,
                "name": "Thursday",
                "startTime": "2021-10-28T06:00:00-04:00",
                "endTime": "2021-10-28T18:00:00-04:00",
                "isDaytime": true,
                "temperature": 62,
                "temperatureUnit": "F",
                "temperatureTrend": null,
                "windSpeed": "13 mph",
                "windDirection": "NE",
                "icon": "https://api.weather.gov/icons/land/day/rain_showers/rain_showers,30?size=medium",
                "shortForecast": "Chance Rain Showers",
                "detailedForecast": "A chance of rain showers. Mostly cloudy, with a high near 62. Northeast wind around 13 mph, with gusts as high as 23 mph. Chance of precipitation is 30%."
            }
        ]
    }
}
"""
}
