//
//  ContentView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            
            Text("Seattle")
                .font(.system(size: 30, weight: .bold, design: .rounded))
            
            Text("Sep 19 1996")
            HStack(alignment: .top) {
                Text("60")
                    .font(.system(size: 160, weight: .regular))
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .bold()
            }
            
            // Details
            HStack(spacing: 40){
                VStack {
                    Image(systemName: "wind")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Windy")
                }
               
                VStack {
                    Image(systemName: "wind")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Windy")
                }
                
                VStack {
                    Image(systemName: "wind")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Windy")
                }
            }
            .foregroundColor(.white)
            .padding(.all, 32)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.black)
            )
        }
        .onAppear(perform: {
            locationManager.requestLocationPermission()
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
