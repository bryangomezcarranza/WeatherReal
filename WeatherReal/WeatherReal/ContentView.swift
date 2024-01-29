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

    @State var state: String?
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView(.init()) {
                    TabView {
                        ForEach(0..<3) { _ in
                            GeometryReader { geo in
                                ZStack {
                                    
                                    Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255).ignoresSafeArea(.all)
                                    
                                    
                                    VStack {
                                        Spacer()
                                        Text(viewModel.place)
                                            .font(.system(size: 40, weight: .bold, design: .rounded))
                                        
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
                        }
                    }
                    .background(Color.black.edgesIgnoringSafeArea(.all))
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .ignoresSafeArea()
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
    
    func getAngle(xOffset: CGFloat) -> Double  {
        let temporaryAngle = xOffset / (width / 2)
        let rotationDegree: CGFloat = 25
        return Double(temporaryAngle * rotationDegree)
    }
}


#Preview {
    ContentView()
}
