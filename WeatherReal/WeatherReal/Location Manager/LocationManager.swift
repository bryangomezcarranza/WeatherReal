//
//  LocationManager.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    @Published var locationGranted: Bool = false

    
    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    public func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        locationGranted = authorizationStatus == .authorizedWhenInUse
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Access authorized.")
        case .denied, .restricted:
            print("Access denied or restricted.")
        case .notDetermined:
            print("Authorization not determined.")
        @unknown default:
            print("Unknown authorization")
        }
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            coordinates = location.coordinate
        }
    }
}

