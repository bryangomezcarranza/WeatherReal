//
//  WeatherView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/30/24.
//

import SwiftUI

struct DefaultWeatherView: View {
    
    var viewModel: WeatherViewModel
    @ObservedObject var locationManager = LocationManager()
    @Binding var isSheetPresented: Bool
    
    @State private var currentWeatherType: WeatherType?
    @State private var randomBackgroundColor: Color = Color.random()
    
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                determineBackground(description: viewModel.weatherDescription).ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        
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
                        Text("      ")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
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
                        descriptionBlock(image: "humidity", text: "Humidity", measurment: viewModel.humidity, unit: "%")
                        descriptionBlock(image: "wind", text: "Wind", measurment: viewModel.wind, unit: "mph")
                        descriptionBlock(image: "eye", text: "Visibility", measurment: viewModel.visibility, unit: "mi")
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
                
                //if locationManager.locationGranted {
                  
                //}
                locationManager.requestLocationPermission()
                viewModel.fetchCurrentLocationWeatherDetails()
                
            })
            .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
            .rotation3DEffect(Angle(degrees: getAngle(xOffset: geo.frame(in: .global).minX)), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 2.5)
        }
    }
    
    func descriptionBlock(image: String, text: String, measurment: Double, unit: String = "") -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 30, height: 30)
            Text("\(measurment) " + unit).bold()
            Text(text).font(.system(size: 8))
        }
    }
    
    func getAngle(xOffset: CGFloat) -> Double  {
        let temporaryAngle = xOffset / (width / 2)
        let rotationDegree: CGFloat = 25
        return Double(temporaryAngle * rotationDegree)
    }
    
   // @MainActor
    func determineBackground(description: String) ->  Color? {
        switch description {
        case  "clear sky":
            return  WeatherType.clearSky.backgroundImage
        case "few clouds":
            return  WeatherType.fewClouds.backgroundImage
        case "rain":
            return  WeatherType.rain.backgroundImage
        case "thunderstorm":
            return  WeatherType.thunderstorm.backgroundImage
        case "snow":
            return  WeatherType.snow.backgroundImage
        case "mist":
            return  WeatherType.mist.backgroundImage
        case "shower rain":
            return  WeatherType.showerRain.backgroundImage
        case "broken clouds":
            return  WeatherType.brokenClouds.backgroundImage
        case "scattered clouds":
            return  WeatherType.scatteredClouds.backgroundImage
        default:
            return randomBackgroundColor

        }
    }
}

#Preview {
    DefaultWeatherView(viewModel: WeatherViewModel(), isSheetPresented: .constant(true))
}
