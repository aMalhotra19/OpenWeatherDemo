//
//  WeatherModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/7/21.
//

import Foundation

struct WeatherModel: Decodable {
    let name: String?  
    let timezone: Int?
    let wind: Wind
    let id: Int?
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Wind: Decodable {
    let speed: Double
    let deg: Double
    let gust: Double
}

