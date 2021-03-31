//
//  CollectionView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI

struct TestData: Identifiable {
    let id = UUID().uuidString
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
}

struct CollectionView: View {
    
    let dataList:[TestData] = [
        TestData(name: "김광수1"),
        TestData(name: "김광수2"),
        TestData(name: "김광수3"),
        TestData(name: "김광수4"),
        TestData(name: "김광수5"),
        TestData(name: "김광수6"),
        TestData(name: "김광수7"),
        TestData(name: "김광수8"),
        TestData(name: "김광수9"),
        TestData(name: "김광수0"),
        TestData(name: "김광수3"),
        TestData(name: "김광수4")
    ]
    
    let columns: Int = 3
    let hPadding: CGFloat = 10
    let vPadding: CGFloat = 10
    let hSpacing: CGFloat = 10
    let vSpacing: CGFloat = 10
    
    /*
     QGrid(Storage.people,
               columns: 3,
               columnsInLandscape: 4,
               vSpacing: 50,
               hSpacing: 20,
               vPadding: 100,
               hPadding: 20) { person in
                 GridCell(person: person)
         }
     */
    
//    init(_ dataList: [T:Identifiable],
//         columns: Int = 2,
//         hPadding: CGFloat = 10,
//         vPadding: CGFloat = 10,
//         hSpacing: CGFloat = 10,
//         vSpacing: CGFloat = 10)
    
    var body: some View {
        
        GeometryReader { gr in
            
            let width: CGFloat = (gr.size.width - hPadding*2 - hSpacing*2 - vSpacing) / CGFloat(columns)
            VStack(alignment: .leading, spacing: vSpacing) {
                ForEach(0..<Int(ceil(Double(dataList.count)/Double(columns)))) { index in
                    HStack(spacing: hSpacing) {
                        
                        ForEach(0..<columns) { column in
                            if dataList.count > index*columns + column {
                                Text("\(dataList[index*columns+column].name)")
                                    .frame(width: width, height: width)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, hPadding)
            .padding(.vertical, vPadding)
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView()
    }
}
