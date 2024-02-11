//
//  ContentView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import SwiftUI
import TipKit

struct FinalView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State var isSheetPresented: Bool = false
    @State private var selectedTab: Int = 0
    @State var animateStates: [Int: Bool] = [:]
    
    let searchTip = SearchTip()
    
    var body: some View {
        ScrollView(.init()) {
            TabView(selection: $selectedTab) {
                DefaultWeatherView(viewModel: viewModel, isSheetPresented: $isSheetPresented).tag(0)
                    .fullScreenCover(isPresented: $isSheetPresented) {
                        AddPlaceView(viewModel: viewModel, isSheetPresented: $isSheetPresented, searchTip: searchTip)
                            .presentationBackground(.ultraThinMaterial)
                    }
                    .onAppear {
                        isSheetPresented = false
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
                // Needed to reset animation when coming back to this specific tab view
                viewModel.resetAnimationStateForTab(0)
                //animateStates[viewModel.weatherDataArray[].id] = false
                if newTab == 0 {
                    viewModel.animateStates[newTab] = true
                } else {
                    // Trigger animation if tabview equals the current weatherID
                    viewModel.weatherDataArray.indices.forEach { index in
                        animateStates[viewModel.weatherDataArray[index].id] = viewModel.weatherDataArray[index].id == newTab
                    }
                }
                
            }
        }
        .ignoresSafeArea()

    }
}

#Preview {
    FinalView()
}
