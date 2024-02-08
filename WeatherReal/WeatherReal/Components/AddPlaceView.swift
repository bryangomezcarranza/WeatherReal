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
               HStack {
                   Spacer()
                   Button(action: {
                       // Dismiss the sheet
                       isSheetPresented = false
                   }) {
                       Image(systemName: "xmark")
                           .foregroundColor(.black)
                   }
               }
               Text("Search for City")
                   .font(.title)
                   .bold()
                   .padding()
               
               // Your search bar here
               TextField("City name", text: $newCity)
                   .padding()
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .textInputAutocapitalization(.words)
               
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
                       .background(Color.black)
                       .cornerRadius(20)
               }
               
               Spacer()
           }
           .padding()
       }
   }

#Preview {
    AddPlaceView(viewModel: WeatherViewModel(), isSheetPresented: .constant(false))
}
