//
//  WeatherViewModel.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/26/24.
//

import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var place: String = "- -"
    @Published var temp: Double = 0.0
    @Published var weatherDescription: String = "- -"
    
    let todaysDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMMM"
        return dateFormatter.string(from: Date())
    }()
    
    private let locationManager = LocationManager()
    private let weatherManager = NetworkServiceManager()
    
    func fetchCurrentLocationWeatherDetails() {
        Task {
            do {
                let location = locationManager.coordinates
                let response = try await weatherManager.getCurrentWeather(latitute: location?.latitude ?? 0.0, longitude: location?.longitude ?? 0.0)
                
                place = response.name
                temp = response.main.temp
                weatherDescription = response.weather.first?.description ?? "- -"
                
                
            } catch {
                print("Error fetching weather data")
            }
            
        }
    }
    
}

                                                                     
