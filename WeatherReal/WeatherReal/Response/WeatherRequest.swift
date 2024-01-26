//
//  WeatherRequest.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import Foundation

public struct WeatherResponse: Codable {
    var coord: WeatherCordinateResponse
    var weather: [Weather]
    var main: MainResponse
    var wind: WindResponse
    var name: String
}
public struct WeatherCordinateResponse: Codable {
    var long: Double
    var lat: Double
}

public struct Weather: Codable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

public struct MainResponse: Codable {
    var temp: Double
    var humidity: Double
}

public struct WindResponse: Codable {
    var speed: Double
}


