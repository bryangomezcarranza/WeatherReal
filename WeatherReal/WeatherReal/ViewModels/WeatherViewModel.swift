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
    private let weatherManager = NetworkServiceManager()
    
    @Published var temp: Double
    
    
    init(weather: WeatherResponse? = nil, temp: Double = 0) {
        self.weather = weather
        self.temp = temp
    }
    
    func fetchData(weatherManager: NetworkServiceManager = NetworkServiceManager()) async {
        
        if let location = locationManager.coordinates {
            let response = try? await weatherManager.getCurrentWeather(latitute: location.latitude, longitude: location.longitude)
            
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
