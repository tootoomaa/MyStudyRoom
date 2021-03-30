//
//  DateListView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/30.
//

import SwiftUI


struct DateListView: View {
    
    let dateList = TimeUtil().getDayStringByCurrentDay(type: .weak)
    
    let todayHealthHistory: [String] = ["수면", "혈당", "식사", "알부민"]
    
    @State private var selectedIndex = 0
    
    var body: some View {
        ScrollView {
            
            Image("wwdc")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                
                Text("2020년 12월")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 23)
                    .padding(.bottom, 16)
                    
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<dateList.count) { index in
                            Text("\(index)")
                                .frame(width: Constants.viewWitdh/7, height: 100)
                                .background( Color.white)
                                .cornerRadius(20)
                        }
                    }
                }.frame(height: 100)
                
                HStack(alignment: .center, spacing: 0) {
                    ForEach(dateList, id: \.self) { date in
                        
                        VStack {
                            Text("1")
                                .padding(.bottom, 10)
                            Text(date)
                        }.frame(width: Constants.viewWitdh/7, height: 100)
                        .background(Color.white)
                        .cornerRadius(20)
                    }
                }
                
                List {
                    Section(header: Text("오늘 건강내역")) {
//                        Text("리스트1")
//                        Text("리스트2")
//                        Text("리스트3")
                        ForEach(0..<todayHealthHistory.count) { list in
                            Rectangle()
                                .background(Color.red)
                                .frame(width: Constants.viewWitdh/3,
                                       height: Constants.viewWitdh/3)
                        }
                    }
                    
                    Section(header: Text("오늘 활동 내역")) {
                        Text("리스트1")
                        Text("리스트2")
                        Text("리스트3")
                    }
                }.background(Color.red)
                .frame(height: 400)
            }
            .padding(.top, 30)
            .background(RoundedCorners(color: .green, tl: 30, tr: 30, bl: 0, br: 0))
            .offset(y: -35)
//            List {
//                Text("Test")
//            }
//            .frame(width: Constants.viewWitdh, height: 1000)
//            .background(RoundedCorners(color: .green, tl: 30, tr: 30, bl: 0, br: 0))
//            .offset(y: -40)
                
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DateListView_Previews: PreviewProvider {
    static var previews: some View {
        DateListView()
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

