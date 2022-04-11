//
//  ContentView.swift
//  WeatherAnimation
//
//  Created by 김광수 on 2022/04/09.
//

import SwiftUI

struct ContentView: View {
    
    // array to hold the three weelky weather data Option
    @State var dataArray = [DataModel.temperature, DataModel.precipitation, DataModel.wind]
    
    var capuleWidth: CGFloat = 14
    
    @State private var pickerSelection = 0
    @State private var isOn = false
    @State private var animateTemp = true
    @State private var animatePrecip = false
    @State private var animateWind = false
    @State private var animateTempleImage = true
    @State private var animatePrecipImage = false
    @State private var animateWindImage = false
    @State private var animateGraph = false
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color(.sRGB, red: 255/255, green: 195/255, blue: 0/255).edgesIgnoringSafeArea(.all)
            
            VStack {
                // MARK: - TITLE
                Text("Weather")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .font(.title)
                    .shadow(color: .black, radius: 1, x: 0, y: 0)
                
                // MARK: - PIKER
                PickerView(pickerSelection: $pickerSelection)
                    .onReceive([pickerSelection].publisher.first()) { value in
                        withAnimation(Animation.easeOut(duration: 1.0)) {
                            if value == 0 {
                                animateTemp = true
                                animatePrecip = false
                                animateWind = false
                                
                                animateTempleImage = true
                                animatePrecipImage = false
                                animateWindImage = false
                            } else if value == 1 {
                                animatePrecip = true
                                animateTemp = false
                                animateWind = false
                                
                                animateTempleImage = false
                                animatePrecipImage = true
                                animateWindImage = false
                            } else {
                                animateWind = true
                                animateTemp = false
                                animatePrecip = false
                                
                                animateTempleImage = false
                                animatePrecipImage = false
                                animateWindImage = true
                            }
                        }
                    }
                
                // MARK: -  WEEKLY GRAPH
                ZStack {
                    HStack(spacing: 20) {
                        ForEach(dataArray[pickerSelection], id: \.day) { data in
                            VStack {
                                WeeklyGraph(dayHeightData: data, width: 350 / capuleWidth)
                                Text("\(data.day)")
                                    .font(.caption)
                            }
                        }
                    } //: HSTACL
                    .animation(.spring(response: 0.9, dampingFraction: 0.6), value: pickerSelection)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1).shadow(color: .black, radius: 8, x: 3, y: 3)
                        .padding(.horizontal, 10)
                } //: ZSTACK
                
                // MARK: - Bottom Imformation
                GeometryReader { geo in
                    VStack {
                        if animateTemp {
                            Text("Temperature").font(.title).fontWeight(.medium)
                                .shadow(color: .black, radius: 1, x: 0, y: 2)
                                .transition(AnyTransition.offset(x: 300))
                                .animation(.easeOut(duration: 1.0), value: animateTemp)

                        }
                        
                        if animatePrecip {
                            Text("Pricipitation").font(.title).fontWeight(.medium)
                                .shadow(color: .black, radius: 1, x: 0, y: 2)
                                .transition(AnyTransition.offset(x: -300))
                                .animation(.easeOut(duration: 1.0), value: animatePrecip)
                        }

                        if animateWind {
                            Text("Wind").font(.title).fontWeight(.medium)
                                .shadow(color: .black, radius: 1, x: 0, y: 2)
                                .transition(AnyTransition.offset(x: 300))
                                .animation(.easeOut(duration: 1.0), value: animateWind)
                        }
                    } //: Text VSTACK
                    .position(x: geo.size.width/2, y: geo.size.height * 0.2)
                    
                    VStack {
                        if animateTempleImage {
                            Image("tempImage").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width, height: geo.size.height/2)
                                .position(y: geo.size.height/2).transition(AnyTransition.offset(y: 300))
                                .animation(Animation.easeOut(duration: 1.0), value: animateTempleImage)
                        }
                        
                        if animatePrecipImage {
                            Image("precip").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width, height: geo.size.height/2)
                                .position(y: geo.size.height/2).transition(AnyTransition.offset(x: 300))
                                .animation(Animation.easeOut(duration: 1.0), value: animatePrecipImage)
                        }
                        
                        if animateWindImage {
                            Image("windImage").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width, height: geo.size.height/2)
                                .position(y: geo.size.height/2).transition(AnyTransition.offset(x: -300))
                                .animation(Animation.easeOut(duration: 1.0), value: animateWindImage)
                        }
                    } //: Image VSTACK
                    .position(x: geo.size.width, y: geo.size.height * 0.6)
                } //: GEO
            } //: VSTACK
        } //: ZSTACK
    }
}

struct WeeklyGraph: View {
    var dayHeightData: DataModel
    var width: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().opacity(0.3)
                    .frame(width: width + 2, height: 200)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black.opacity(0.4), lineWidth: 1.5)
                            .shadow(color: .black, radius: 8, x: 0, y: 0)
                    )
                
                Capsule()
                    .frame(width: width, height: dayHeightData.data * 200)
                    .overlay(RoundedRectangle(cornerRadius: 20).fill(Color.white).opacity(0.9))
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
