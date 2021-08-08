//
//  WeatherViewModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import Foundation
protocol WeatherDisplayable {
    func refreshUI()
    func showIndicator()
    func hideIndicator()
    func showAlert(_ error: NetworkError?)
}

class WeatherViewModel {

    var lat: Double
    var long: Double
    var weatherModel: WeatherModel?
    var delegate: WeatherDisplayable?
    var errorMessage: String?
    
    init(lat: Double, long: Double) {
        self.lat = lat
        self.long = long
    }
    
    var temperature: String? {
        return String(weatherModel?.main.temp ?? 0)
    }
    
    var humidity: String? {
        return String(weatherModel?.main.humidity ?? 0)
    }
    
    var wind: String? {
        return String(weatherModel?.wind.speed ?? 0)
    }
    
    var name: String? {
        return weatherModel?.name?.count == 0 ? "Unknown location" : weatherModel?.name
    }
    
    var main: String? {
        return weatherModel?.weather.first?.main
    }
    
    func fetchWeather() {
        delegate?.showIndicator()
        BookmarkManager.shared.fetchWeather(for: lat, and: long) { (result) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let weather):
                    self?.weatherModel = weather
                    self?.refresh()
                case .failure(let error):
                    self?.delegate?.showAlert(error)
                }
                self?.delegate?.hideIndicator()
            }
        }
        
    }
    
    func refresh() {
        self.delegate?.refreshUI()
    }
}
