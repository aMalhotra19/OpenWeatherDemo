//
//  BookmarkManager.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import Foundation
import MapKit

enum NetworkError: Error {
    case networkError
    case decodingError
}

class BookmarkManager {
    
    static var shared = BookmarkManager()
    private init() {}
    
    var bookmarks = [Bookmark]()
    var annotations = [MKAnnotation]()
    var service = LocationService()
    
    func fetchWeather(for lat: Double, and longitude: Double, handler completion: @escaping(Result<WeatherModel, NetworkError>) -> ()) {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lat)&appid=fae7190d7e6433ec3a45285ffcf55c86") else {
            return
        }
        service.fetchWeather(url:url) { (result) in
            switch result {
            case .success(let weather):
                completion(.success(weather))
                print("success")
            case .failure(let error):
                completion(.failure(error))
                print("failure")
            
            }
        }
    }
}
