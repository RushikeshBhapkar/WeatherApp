//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Rushikesh on 04/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import UIKit
import AFDateHelper

class DetailViewController: BaseViewController {
    
    let presenter = DetailPresenter(forecastService: ForecastService())
    var forecasts = [ForecastViewData]()
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        presenter.getWeatherForecast(locationID: "1-72837")
    }
}

extension DetailViewController : DetailView {
    func startLoading() {
        showActivityIndicator(toggle: true)
    }
    
    func finishLoading() {
        showActivityIndicator(toggle: false)
    }
    
    func setForcastDataForLocation(forcastData: [ForecastViewData]) {
        self.forecasts = forcastData
        DispatchQueue.main.async {
             self.tableView.reloadData()
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts[section].forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        let forecast = forecasts[indexPath.section].forecastData
        let dayForecast = forecast[indexPath.row]
        cell.timeLabel.text = dayForecast.start.toString(format: DateFormatType.custom("HH"))
        cell.tempLabel.text = dayForecast.temperature.value?.description
        cell.windLabel.text = Int(dayForecast.wind.speed).description

        if(Int(dayForecast.precipitation.min!) > 0 || Int(dayForecast.precipitation.max!) > 0) {
            cell.prepLabel.text = dayForecast.precipitation.min!.description + "-" + dayForecast.precipitation.max!.description + "mm"
        }
        
        //TODO : revisit Weather symbols logic
        var imageName = ""
        if(dayForecast.symbol.n < 10) {
            imageName = "0" + dayForecast.symbol.n.description
        } else {
            imageName = dayForecast.symbol.n.description
        }
        if(dayForecast.symbol.sunup) {
            imageName = imageName + "d"
        } else {
            imageName = imageName + "n"
        }
        let image = UIImage(named: imageName)
        if(image != nil) {
            cell.forecastImageView.image = image
        } else {
            cell.forecastImageView.image = UIImage(named: "07d")
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getHeaderView(tableView: tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func getHeaderView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
       
        let frameWidth = tableView.frame.width
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frameWidth, height: 60))
        //Added to support dark mode
        if #available(iOS 13.0, *) {
            view.backgroundColor = UIColor.secondarySystemBackground
        } else {
            view.backgroundColor = UIColor.white
        }
        let forcastViewObj = forecasts[section]
        let dateLabel = UILabel(frame: CGRect(x: 15, y: 0, width: frameWidth - 15, height: 40))
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.text = forcastViewObj.date.toString(style: DateStyleType.weekday) + " " +
               forcastViewObj.date.toString(style: DateStyleType.ordinalDay) + " " +
               forcastViewObj.date.toString(style: DateStyleType.month)
        view.addSubview(dateLabel)

        let font = UIFont.systemFont(ofSize: 10)
        let labelWidth = frameWidth/5
        let labelHeight = 20
        let timeLabel = UILabel(frame: CGRect(x: 0, y: 40, width: Int(labelWidth), height: labelHeight))
        timeLabel.font = font
        timeLabel.textAlignment = .center
        timeLabel.text = "Time(HH)"
        view.addSubview(timeLabel)
        
        let forecastLabel = UILabel(frame: CGRect(x: Int(labelWidth), y: 40, width: Int(labelWidth), height: 20))
        forecastLabel.font = font
        forecastLabel.textAlignment = .center
        forecastLabel.text = "Forecast"
        view.addSubview(forecastLabel)
        
        let tempLabel = UILabel(frame: CGRect(x: Int(2*labelWidth), y: 40, width: Int(labelWidth), height: 20))
        tempLabel.font = font
        tempLabel.textAlignment = .center
        tempLabel.text = "Temp."
        view.addSubview(tempLabel)

        let precipitationLabel = UILabel(frame: CGRect(x: Int(3*labelWidth), y: 40, width: Int(labelWidth), height: 20))
        precipitationLabel.font = font
        precipitationLabel.textAlignment = .center
        precipitationLabel.text = "Precipitation"
        view.addSubview(precipitationLabel)
        
        let windLabel = UILabel(frame: CGRect(x: Int(4*labelWidth), y: 40, width: Int(labelWidth), height: 20))
        windLabel.font = font
        windLabel.textAlignment = .center
        windLabel.text = "Wind"
        view.addSubview(windLabel)
        
        return view
    }
}
