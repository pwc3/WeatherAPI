import Foundation

public class WeatherService {

    let client: RESTClient

    required public init(client: RESTClient) {
        self.client = client
    }

    public static var `default`: WeatherService = {
        let headers: [String: String] = [
            "User-Agent": "(rocketinsights.com, paul@rocketinsights.com)",
            "Accept": "application/geo+json"
        ]

        let baseURL = "https://api.weather.gov"

        let client = URLSessionRESTClient(baseURL: baseURL, headers: headers, logIncomingJSON: true)
        return WeatherService.init(client: client)
    }()
}
