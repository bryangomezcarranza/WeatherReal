//
//  WeatherViewModel.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/26/24.
//

import Foundation
import SwiftUI


@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var place: String = "- -"
    @Published var temp: Double = 0.0
    @Published var weatherDescription: String = "- -"
    @Published var humidity: Double = 0.0
    @Published var wind: Double = 0.0
    @Published var visibility: Double = 0.0
    @Published var weatherDataArray: [WeatherResponse] = []
    @Published var animateStates: [Int: Bool] = [:]
    @Published var hasAnimatedDefaultView: Bool = false
    
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
                humidity = response.main.humidity
                wind = response.wind.speed
                visibility = (response.visibility / 5280).rounded()
            } catch {
                print("Error fetching weather data")
            }
        }
    }
    
    
    func fetchCitiesWithID(cityName: String) {
        Task {
            do {
                let response = try await weatherManager.fetchWeatherDetailsWithName(cityName: cityName)
                weatherDataArray.append(response)
                print(weatherDataArray.first?.name ?? "no city")
            } catch {
                print("Error fetching weather data for city name")
            }
        }
    }
    
    func resetAnimationStateForTab(_ tab: Int) {
        animateStates[tab] = false
    }
}

                                                                     
