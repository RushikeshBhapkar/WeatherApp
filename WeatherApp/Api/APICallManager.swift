//
//  APICallManager.swift
//  WeatherApp
//
//  Created by Rushikesh on 03/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

let API_BASE_URL = "https://www.yr.no/api/v0"

class APICallManager {
    static let instance = APICallManager()
    
    enum RequestMethod {
        case get
        case post
    }
    
    enum Endpoint: String {
        case locationSuggestion = "/locations/Suggest"
        case locationForecast = "/locations/"
        
    }
    
    func callAPIGetLocationSuggestion(queryString: String,
                                      onSuccess successCallback: ((_ locationSuggestion: LocationSuggestion) -> Void)?,
                                      onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        var components = URLComponents(string: API_BASE_URL + Endpoint.locationSuggestion.rawValue)!
        components.queryItems = [
            URLQueryItem(name: "q", value: queryString),
            URLQueryItem(name: "accuracy", value: "1000"),
            URLQueryItem(name: "language", value: "en")
        ]
        
        let serviceUrl = components.url?.absoluteString
        guard let url = URL(string: serviceUrl!) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let locationSuggestion = try JSONDecoder().decode(LocationSuggestion.self, from: data)
                successCallback?(locationSuggestion)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                failureCallback?("An error has occured.")
            }
        }.resume()
    }
    
    func callAPIGetWeatherForecast(locationID: String,
                                   onSuccess successCallback: ((_ forecast: Forecast) -> Void)?,
                                   onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        //let serviceUrl = API_BASE_URL + Endpoint.locationForecast.rawValue + locationID + "/forecast"
        let serviceUrl = "https://www.yr.no/api/v0/locations/1-86450/forecast"
        guard let url = URL(string: serviceUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let forecast = try decoder.decode(Forecast.self, from: data)
                successCallback?(forecast)
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                failureCallback?("An error has occured.")
            }
        }.resume()
    }
}
