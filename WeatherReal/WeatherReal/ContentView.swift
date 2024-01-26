//
//  ContentView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = NetworkServiceManager()
    @State var weather: WeatherResponse?
    
    var body: some View {
        ZStack {
            Color(.init(red: 0, green: 206, blue: 209, alpha: 1)).ignoresSafeArea(.all)
            VStack {
                if let weather = viewModel {
                    Text(weather)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    
                    VStack {
                        Text("Friday 19 January")
                            .font(.system(size: 12))
                            .foregroundStyle(.white)
                            .padding(.all, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.black)
                            )
                        
                        Text(weather.weather.first?.main ?? "")
                            .bold()
                    }
                    
                    HStack(alignment: .top) {
                        Text(String(Int(weather.main.temp.rounded())))
                            .font(.system(size: 200, weight: .regular))
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
        }
        .onAppear(perform: {
            print("View appeared!")
            locationManager.requestLocationPermission()
            viewModel.fetchData()
        })
    }
    
    func getData() {
        Task {
            if let location = locationManager.coordinates {
                do {
                    weather = try await weatherManager.getCurrentWeather(latitute: location.latitude , longitude: location.longitude)
                    print("GOT THE DATA")
                } catch {
                    print("did not work")
                }
            }
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
}


#Preview {
    ContentView()
}
