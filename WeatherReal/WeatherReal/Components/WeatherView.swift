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
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255).ignoresSafeArea(.all)
                
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
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .bold()
                    }
                    
                    // TODO: Make this its own view
                    
                   
                    
                    HStack(spacing: 40){
                        
                        let visibilityInFt = cityWeather.visibility
                        let visibilityInMiles = (cityWeather.visibility / 5280).rounded()
                        
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
}

#Preview {
    WeatherView(cityWeather:  WeatherResponse(coord: WeatherCordinateResponse.init(lon: 0.0, lat: 0.0), weather: [Weather(id: 0.0, main: "", description: "", icon: "")], main: MainResponse(temp: 0.0, humidity: 0.0), visibility: 10, wind: WindResponse(speed: 0.0), sys: SysReponse(id: 0), name: "") , viewModel: WeatherViewModel())
}
