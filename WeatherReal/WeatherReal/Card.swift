//
//  Card.swift
//  WeatherReal
//
//  Created by Bryan Gomez on 1/28/24.
//

import SwiftUI


struct Card: View {
    var body: some View {
        Main()
    }
}


struct Main: View {
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        TabView {
            ForEach(data) {
                story in GeometryReader { geo in
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color("top"), story.color]), startPoint: .top, endPoint: .bottomTrailing)
                           // .cornerRadius(10) // You can add corner radious.. 
                        
                        Image(story.story)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                Capsule()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(height: 2.5)
                                
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: story.offset, height: 2.5)
                            }
                            
                            HStack(spacing: 12) {
                                Image(story.story)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipped()
                                Text(story.name)
                                    .foregroundStyle(Color.white)
                                    .fontWeight(.bold)
                                Text(story.time)
                                    .foregroundStyle(Color.white)
                            }
                            
                            Spacer()
                            
                        }
                        
                        .padding(.all)
                        
                    }
                    .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
                    .rotation3DEffect(Angle(degrees: getAngle(xOffset: geo.frame(in: .global).minX)), axis: (x: 0.0, y: 1.0, z: 0.0), anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing, perspective: 2.5)
                    
                }
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
 func getAngle(xOffset: CGFloat) -> Double  {
        let tempAngle = xOffset / (width / 2)
        let rotationDegree: CGFloat = 25
        return Double(tempAngle * rotationDegree)
    }
                                   
}


struct Story: Identifiable {
    var id = UUID().uuidString
    var story: String
    var name: String
    var time: String
    var offset: CGFloat
    var color: Color
}
    
    var data = [
        Story(story: "1", name: "Kathy", time: "5h", offset: 100, color: .teal),
        Story(story: "2", name: "Robert", time: "2h", offset: 100, color: .green),
        Story(story: "3", name: "Bryan", time: "2h", offset: 100, color: .black)
    ]





#Preview {
    Card()
}
