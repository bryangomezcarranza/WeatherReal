//
//  WeatherRequest.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import Foundation

public struct WeatherResponse: Codable, Identifiable {
    
    // Identifiable conformance using the 'name' property as the identifier
    public var id: String { name }
    
    var coord: WeatherCordinateResponse
    var weather: [Weather]
    var main: MainResponse
    var wind: WindResponse
    var sys: SysReponse
    var name: String
}
public struct WeatherCordinateResponse: Codable {
    var lon: Double
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

public struct SysReponse: Codable {
    var id: Int
}


