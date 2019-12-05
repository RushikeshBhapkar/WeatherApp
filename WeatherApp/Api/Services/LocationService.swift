//
//  SearchService.swift
//  WeatherApp
//
//  Created by Rushikesh on 03/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

class LocationService {
    public func getLocationSuggestion(queryString:String, onSuccess successCallback: ((_ locationSuggestion: LocationSuggestion) -> Void)?,
                                 onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instance.callAPIGetLocationSuggestion(
            queryString: queryString,
            onSuccess: { (locationSuggestion) in
                successCallback?(locationSuggestion)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }
}

