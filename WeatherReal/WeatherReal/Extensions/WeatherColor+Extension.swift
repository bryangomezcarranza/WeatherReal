//
//  WeatherColor+Extension.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 2/6/24.
//

import SwiftUI

enum WeatherType: String {
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case rain = "rain"
    case thunderstorm = "thunderstorm"
    case snow = "snow"
    case mist = "mist"
    case showerRain = "shower rain"
    case brokenClouds = "broken clouds"
    case scatteredClouds = "scattered clouds"

    var backgroundImage: Color? {
        switch self {
        case .clearSky:
            return  Color(red: 64 / 255, green: 162 / 255, blue: 245 / 227)
        case .fewClouds:
            return Color(red: 201 / 255, green: 215 / 255, blue: 221 / 255)
        case .rain:
            return Color(red: 99 / 255, green: 122 / 255, blue: 159 / 255)
        case .thunderstorm:
            return  Color(red: 253 / 255, green: 231 / 255, blue: 103 / 255)
        case .snow:
            return  Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
        case .mist:
            return  Color(red: 225 / 255, green: 240 / 255, blue: 218 / 255)
        case .showerRain:
            return  Color(red: 134 / 255, green: 182 / 255, blue: 246 / 255)
        case .brokenClouds:
            return  Color(red: 248 / 255, green: 246 / 255, blue: 244 / 255)
        case .scatteredClouds:
            return  Color(red: 196 / 255, green: 223 / 255, blue: 223 / 255)
        }
    }
}

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
}


