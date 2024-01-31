//
//  ContentView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject var locationManager = LocationManager()
    
    
    var width = UIScreen.main.bounds.width
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var isSheetPresented: Bool = false // New state for sheet presentation
    
    
    var body: some View {
        ScrollView(.init()) {
            TabView {
                    GeometryReader { geo in
                        ZStack {
                            
                            Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255).ignoresSafeArea(.all)
                            
                            
                            VStack {
                                Spacer()
                                
                                HStack(alignment: .center) {
                                    // Button to trigger the sheet
                                    Button(action: {
                                        isSheetPresented.toggle()
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title)
                                            .foregroundColor(.black)
                                            .padding(.leading)
                                    }
                                    .frame(alignment: .leading)
                                   

                                    Spacer()

                                    // Title in the middle
                                    Text(viewModel.place)
                                        .font(.system(size: 40, weight: .bold, design: .rounded))

                                    Spacer()
                                    Spacer()
                                }
                                
                                
                                VStack {
                                    Text(viewModel.todaysDate)
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.all, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(Color.black)
                                        )
                                    
                                    Text(viewModel.weatherDescription)
                                        .bold()
                                }
                                Spacer()
                                
                                HStack(alignment: .top) {
                                    Text(String(Int(viewModel.temp.rounded())))
                                        .font(.system(size: 200, weight: .bold))
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .bold()
                                }
                                
                                // TODO: Make this its own view
                                HStack(spacing: 40){
                                    descriptionBlock(image: "wind", text: "Windy")
                                    descriptionBlock(image: "wind", text: "Windy")
                                    descriptionBlock(image: "wind", text: "Windy")
                                }
                                .foregroundColor(.white)
                                .padding(.all, 32)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.black)
                                )
                                
                                Spacer()
                            }
                        }
                        .onAppear(perform: {
                            locationManager.requestLocationPermission()
                            viewModel.fetchCurrentLocationWeatherDetails()
                        })
                        .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
                        .rotation3DEffect(Angle(degrees: getAngle(xOffset: geo.frame(in: .global).minX)), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 2.5)
                    }
                ForEach(viewModel.weatherDataArray, id: \.id) { cityWeather in
                    GeometryReader { geo in
                        ZStack {
                            
                            Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255).ignoresSafeArea(.all)
                            
                            
                            VStack {
                                Spacer()
                                
                                HStack(alignment: .center) {
                                    // Button to trigger the sheet
                                    Button(action: {
                                        isSheetPresented.toggle()
                                    }) {
                                        Image(systemName: "magnifyingglass")
                                            .font(.title)
                                            .foregroundColor(.black)
                                            .padding(.leading)
                                    }
                                    .frame(alignment: .leading)
                                   

                                    Spacer()

                                    // Title in the middle
                                    Text(cityWeather.name)
                                        .font(.system(size: 40, weight: .bold, design: .rounded))

                                    Spacer()
                                    Spacer()
                                }
                                
                                
                                VStack {
                                    Text("No date yet")
                                        .font(.system(size: 12))
                                        .foregroundStyle(.white)
                                        .padding(.all, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .foregroundColor(Color.black)
                                        )
                                    
                                    Text(cityWeather.weather.first?.description ?? "- -")
                                        .bold()
                                }
                                Spacer()
                                
                                HStack(alignment: .top) {
                                    Text(String(Int(cityWeather.main.temp.rounded())))
                                        .font(.system(size: 200, weight: .bold))
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .bold()
                                }
                                
                                // TODO: Make this its own view
                                HStack(spacing: 40){
                                    descriptionBlock(image: "wind", text: "Windy")
                                    descriptionBlock(image: "wind", text: "Windy")
                                    descriptionBlock(image: "wind", text: "Windy")
                                }
                                .foregroundColor(.white)
                                .padding(.all, 32)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.black)
                                )
                                
                                Spacer()
                            }
                        }
                        .onAppear(perform: {
                            locationManager.requestLocationPermission()
                            viewModel.fetchCurrentLocationWeatherDetails()
                        })
                        .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
                        .rotation3DEffect(Angle(degrees: getAngle(xOffset: geo.frame(in: .global).minX)), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 2.5)
                    }
                }
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .ignoresSafeArea()
        .sheet(isPresented: $isSheetPresented) {
            // Content of the sheet with search bar and add button
            SheetContent(viewModel: viewModel)
        }
    }
    
    func descriptionBlock(image: String, text: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 30, height: 30)
            Text(text)
        }
    }
    
    func getAngle(xOffset: CGFloat) -> Double  {
        let temporaryAngle = xOffset / (width / 2)
        let rotationDegree: CGFloat = 25
        return Double(temporaryAngle * rotationDegree)
    }
}


#Preview {
    ContentView()
}


struct SheetContent: View {
    // Content of the sheet with search bar and add button
    @State private var newCity: String = ""
    @State private var isAddButtonDisabled: Bool = true
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            Text("Add New City")
                .font(.title)
                .padding()
            
            // Your search bar here
            TextField("Enter city name", text: $newCity)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
            
            // Your add button here
            Button(action: {
                // Perform the action to add the city
                // You can use the newCity value here
            
            viewModel.fetchCitiesWithID(cityName: newCity)
                

            }) {
                Text("Add")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding()
    }
}
