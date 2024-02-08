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
    @State private var selectedTab: Int = 0
    @State var animateStates: [Int: Bool] = [:]
    
    var body: some View {
        ScrollView(.init()) {
            TabView(selection: $selectedTab) {
                DefaultWeatherView(viewModel: viewModel, isSheetPresented: $isSheetPresented).tag(0)
                    .onAppear {
                        viewModel.resetAnimationStateForTab(0)
                        viewModel.animateStates[0] = true
                    }
                ForEach(viewModel.weatherDataArray, id: \.id) { cityWeather in
                    WeatherView(cityWeather: cityWeather, viewModel: viewModel, selectedTab: $selectedTab, animateStates: $animateStates).tag(cityWeather.id)
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: selectedTab) { newTab in
                viewModel.resetAnimationStateForTab(0)
                if newTab == 0 {
                        viewModel.animateStates[newTab] = true
                } else {
                    viewModel.weatherDataArray.indices.forEach { index in
                        animateStates[viewModel.weatherDataArray[index].id] = viewModel.weatherDataArray[index].id == newTab
                        print("\(viewModel.weatherDataArray[index].id) == \(newTab)")
                    }
                }

            }
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
