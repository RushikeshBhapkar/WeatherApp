//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Rushikesh on 03/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

struct LocationViewData{
    let name: String
    let category: String
    let subregion: String
    let region: String
}

protocol LocationSuggestionView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setLocationSuggestion(locationSuggestion: [String])
    func setEmptyLocationSuggestion()
}

class SearchPresenter {
    private let locationService:LocationService
    weak private var locationSuggestionView : LocationSuggestionView?
    
    init(locationService:LocationService) {
        self.locationService = locationService
    }
    
    func attachView(view:LocationSuggestionView) {
        locationSuggestionView = view
    }
    
    func detachView() {
        locationSuggestionView = nil
    }
    
    func getLocationSuggestion(query: String) {
        self.locationSuggestionView?.startLoading()
        locationService.getLocationSuggestion(
            queryString: query,
            onSuccess: { (locationSuggestion) in
                self.locationSuggestionView?.finishLoading()
                if (locationSuggestion.embedded.location.count > 0){
                    let locations = locationSuggestion.embedded.location
                    self.locationSuggestionView?.setLocationSuggestion(locationSuggestion: self.getLocationViewData(locations: locations))
                } else {
                    self.locationSuggestionView?.setEmptyLocationSuggestion()
                }
        },
            onFailure: { (errorMessage) in
                self.locationSuggestionView?.finishLoading()
        })
    }
    
    func getLocationViewData(locations:[Location]) -> [String] {
        var locationSuggestions = Array<String>()
        
        locations.forEach { location in
            let locationString = location.name + ", " + location.category.name + ", " + location.subregion.name + "(" + location.region.name + ")"
            locationSuggestions.append(locationString)
        }
        return locationSuggestions
    }
    
    func getLocationViewData(location:Location) -> LocationViewData {
        return LocationViewData(name: location.name,category: location.category.name, subregion: location.subregion.name, region: location.region.name)
    }
}
