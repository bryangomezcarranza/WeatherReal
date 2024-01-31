//
//  ContentView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import SwiftUI

struct FinalView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        ScrollView(.init()) {
            TabView {
                DefaultWeatherView(viewModel: viewModel, isSheetPresented: $isSheetPresented)
                ForEach(viewModel.weatherDataArray, id: \.id) { cityWeather in
                    WeatherView(cityWeather: cityWeather, viewModel: viewModel)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isSheetPresented) {
            AddPlaceView(viewModel: viewModel, isSheetPresented: $isSheetPresented)
        }
    }
}

#Preview {
    FinalView()
}
