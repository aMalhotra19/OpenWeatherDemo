//
//  LocationService.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/7/21.
//

import Foundation

class LocationService {
    func fetchWeather(url: URL, completion: @escaping (Result<WeatherModel, NetworkError>) -> Void ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        guard let data = data else { return }
                        let items = try JSONDecoder().decode(WeatherModel.self, from: data)
                        completion(.success(items))
                    }
                    catch {
                        completion(.failure(NetworkError.decodingError))
                    }
                } else {
                    completion(.failure(NetworkError.networkError))
                }
            }
        }.resume()
    }
}


