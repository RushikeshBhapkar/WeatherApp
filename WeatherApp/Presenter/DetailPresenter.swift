//
//  DetailPresenter.swift
//  WeatherApp
//
//  Created by Rushikesh on 04/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation

struct ForecastViewData{
    let dateString: String
    let date: Date
    let forecastData: [ShortInterval]
}

protocol DetailView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setForcastDataForLocation(forcastData: [ForecastViewData])
}

class DetailPresenter {
    private let forecastService: ForecastService
    weak private var detailView : DetailView?
    
    init(forecastService:ForecastService) {
        self.forecastService = forecastService
    }
    
    func attachView(view:DetailView) {
        detailView = view
    }
    
    func detachView() {
        detailView = nil
    }
    
    func getWeatherForecast(locationID: String) {
        self.detailView?.startLoading()
        
        forecastService.getWeatherForecast(
            locationID: locationID,
            onSuccess: { (forecast) in
                self.detailView?.finishLoading()            
                self.detailView?.setForcastDataForLocation(forcastData: self.convertForcastDataToView(forecastData: self.groupedForecastByDay(forecast.shortIntervals)))
        },
            onFailure: { (errorMessage) in
                self.detailView?.finishLoading()
        })
    }

    func convertForcastDataToView(forecastData: [Date: [ShortInterval]]) -> [ForecastViewData] {
        var forecastViewData = [ForecastViewData]()
        forecastData.forEach { (forecast) in
            let (key, value) = forecast
            let data = ForecastViewData(dateString: key.description,date: key, forecastData: value)
            forecastViewData.append(data)
        }
        forecastViewData = forecastViewData.sorted(by: {
            $0.date.compare($1.date) == .orderedAscending
        })
        return forecastViewData
    }
    
    func groupedForecastByDay(_ episodes: [ShortInterval]) -> [Date: [ShortInterval]] {
      let empty: [Date: [ShortInterval]] = [:]
      return episodes.reduce(into: empty) { acc, cur in
        let components = Calendar.current.dateComponents([.year,.month, .day], from: cur.start)
          let date = Calendar.current.date(from: components)!
          let existing = acc[date] ?? []
          acc[date] = existing + [cur]
      }
    }
}
