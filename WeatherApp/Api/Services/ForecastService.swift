//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Rushikesh on 04/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

class ForecastService {
    public func getWeatherForecast(locationID: String, onSuccess successCallback: ((_ forecast: Forecast) -> Void)?,
                                 onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instance.callAPIGetWeatherForecast(
            locationID: locationID,
            onSuccess: { (forecast) in
                successCallback?(forecast)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}

