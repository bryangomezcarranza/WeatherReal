//
//  SearchTip.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 2/8/24.
//

import Foundation
import TipKit

struct SearchTip: Tip {
    
    var title: Text {
        Text("Add a new city")
    }
    
    var message: Text? {
        Text("Hurry!\nSearch for new city to add to your list")
    }
    
    var image: Image? {
        Image(systemName: "magnifyingglass")
    }

}
