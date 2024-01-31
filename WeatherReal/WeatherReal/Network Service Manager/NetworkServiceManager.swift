//
//  NetworkServiceManager.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import Foundation
import CoreLocation

class NetworkServiceManager {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    private let apiKey = "5bd552b45293215aee12a7c1dc666cf7"
    
    func getCurrentWeather(latitute: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse{
        let endPoint = baseURL + "lat=\(latitute)&lon=\(longitude)&appid=\(apiKey)&units=imperial"
        print(endPoint)
        guard let url = URL(string: endPoint) else { fatalError("Something wrong with URL") }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                fatalError("Invalid response")
            }
            
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return decodedData
            
        } catch {
           fatalError("Could not decode data")
        }
    }
    
    func fetchWeatherDetailsWithName(cityName: String) async throws -> WeatherResponse {
        let trimmedCityName = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
        let newCityName =  trimmedCityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let newCityName = newCityName else { fatalError() }
        let endPoint = baseURL + "q=\(newCityName)&appid=\(apiKey)"
        
        guard let url = URL(string: endPoint) else { fatalError() }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                fatalError("Invalid response")
            }
            
            let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
            return decodedData
            
        } catch {
           fatalError("Could not decode data")
        }
        
    }
}
