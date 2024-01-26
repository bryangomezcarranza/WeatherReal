//
//  WeatherViewModel.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/26/24.
//

import Foundation
import CoreLocation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    
    private let locationManager = LocationManager()
    //private let weatherManager = NetworkServiceManager()
    
    @Published var temp: Double
    @Published var city: String
    
    
    init(weather: WeatherResponse? = nil, temp: Double = 0, city: String = "No city") {
        self.weather = weather
        self.temp = temp
        self.city = city
    }
    
    func fetchData(weatherManager: NetworkServiceManager = NetworkServiceManager()) {
        Task {
            do {
                if let location = locationManager.coordinates {
                    let response = try? await weatherManager.getCurrentWeather(latitute: location.latitude, longitude: location.longitude)
                    
                    if let response {
                        temp = response.main.temp
                        city = response.name
                    }
                }
            } catch  {
                print("ERROR")
            }

        }
       
        
        // if let location = locationManager.coordinates {
        //            do {
        //                weather = try await weatherManager.getCurrentWeather(latitute: location.latitude , longitude: location.longitude)
        //
        //                print("Data was able to be retrieved")
        //            } catch {
        //                print("Data was not able to ")
        //            }
        //        }
    }
}
