//
//  WeatherRealApp.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import SwiftUI
import TipKit

@main
struct WeatherRealApp: App {
    var body: some Scene {
        WindowGroup {
            FinalView()
        }
    }
    init() {
        UIView.appearance(whenContainedInInstancesOf: [TipUIPopoverViewController.self]).tintColor = UIColor.black

        try? Tips.resetDatastore()
        try? Tips.configure([
            .displayFrequency(.immediate),
            .datastoreLocation(.applicationDefault)
        ])
    }
    

}
