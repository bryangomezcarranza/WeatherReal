//
//  AddPlaceView.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/30/24.
//

import SwiftUI

struct AddPlaceView: View {
    // Content of the sheet with search bar and add button
    @State private var newCity: String = ""
    @State private var isAddButtonDisabled: Bool = true
    @ObservedObject var viewModel: WeatherViewModel
    
    @Binding var isSheetPresented: Bool
    
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
            isSheetPresented = false

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


#Preview {
    AddPlaceView(viewModel: WeatherViewModel(), isSheetPresented: .constant(false))
}
