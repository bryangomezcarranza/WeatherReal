//
//  WeatherView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/30/24.
//

import SwiftUI

struct WeatherView: View {
    
    var cityWeather: WeatherResponse
    var viewModel: WeatherViewModel
    var width = UIScreen.main.bounds.width
    
    @State private var randomBackgroundColor: Color = Color.random()
    @State var observer: Bool = false
    
    @Binding var selectedTab: Int
    @Binding var animateStates: [Int: Bool]
  
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                let description = cityWeather.weather.first?.description
                determineBackground(description: description!).ignoresSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Text(cityWeather.name)
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
                        
                        Text(cityWeather.weather.first?.description ?? "- -")
                            .bold()
                    }
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Text(String(Int(cityWeather.main.temp.rounded())))
                            .font(.system(size: 200, weight: .bold))
                            .offset(y: animateStates[cityWeather.id] ?? false ? 0 : 200)
                            .opacity(animateStates[cityWeather.id] ?? false ? 1.0 : 0.0)
                            .animation(.spring().speed(0.5), value: animateStates[cityWeather.id])
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .bold()
                            .offset(x: animateStates[cityWeather.id] ?? false ? 0 : -200)
                            .opacity(animateStates[cityWeather.id] ?? false  ? 1.0 : 0.0)
                            .animation(.spring().speed(0.6), value: animateStates[cityWeather.id])
                    }
                    
                    // TODO: Make this its own view
                    
                    HStack(spacing: 40){
                        
                        let visibilityInFt = cityWeather.visibility
                        let visibilityInMiles = (visibilityInFt / 5280).rounded()
                        
                        descriptionBlock(image: "humidity", text: "Humidity", measurment: cityWeather.main.humidity, unit: "%")
                        descriptionBlock(image: "wind", text: "Wind", measurment: cityWeather.wind.speed, unit: "mph")
                        descriptionBlock(image: "eye", text: "Visibility", measurment: visibilityInMiles, unit: "mi")
                    }
                    .foregroundColor(.white)
                    .padding(.all, 32)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.black)
                    )
                    
                    Spacer()
                }
            }.onAppear {
                animateStates[cityWeather.id] = selectedTab == cityWeather.id
            }

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
    WeatherView(cityWeather:  WeatherResponse(id: 0, coord: WeatherCordinateResponse.init(lon: 0.0, lat: 0.0), weather: [Weather(id: 0.0, main: "", description: "", icon: "")], main: MainResponse(temp: 0.0, humidity: 0.0), visibility: 10, wind: WindResponse(speed: 0.0), sys: SysReponse(id: 0), name: "") , viewModel: WeatherViewModel(), selectedTab: .constant(0), animateStates: .constant([0:true]))
}
