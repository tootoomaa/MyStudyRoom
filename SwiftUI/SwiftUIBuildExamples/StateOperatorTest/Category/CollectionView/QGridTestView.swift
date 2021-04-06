//
//  CollectionView.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/31.
//

import SwiftUI

struct NewTestData: Identifiable {
    let id = UUID().uuidString
    var name: String
    
    init(name: String) {
        self.name = name
    }
}


public struct QGridTestView<Data, Content>: View
    where Data : RandomAccessCollection, Content : View, Data.Element : Identifiable {
    
    let data: [Data.Element]
    private let content: (Data.Element) -> Content
    
    let columns: Int            // Number of Columns
    let hPadding: CGFloat       // view horizontal Padding
    let vPadding: CGFloat       // view vertical Padding
    let hSpacing: CGFloat       // horizontal item spacing
    let vSpacing: CGFloat       // vertical item spacing
    let isScrollable: Bool      // 스크롤 가능 여부 (ScrollView)
    
    
    var vRowCount: Int {        // Vertical Row Count
        Int(ceil(Double(self.data.count)/Double(self.columns)))
    }
    
    public init(_ data: Data,
                columns: Int,
                vSpacing: CGFloat = 10,
                hSpacing: CGFloat = 10,
                vPadding: CGFloat = 10,
                hPadding: CGFloat = 10,
                isScrollable: Bool = true,
                content: @escaping (Data.Element) -> Content) {
        
        self.data = data.map { $0 }
        self.content = content
        self.columns = max(1, columns)
        self.vSpacing = vSpacing
        self.hSpacing = hSpacing
        self.vPadding = vPadding
        self.hPadding = hPadding
        self.isScrollable = isScrollable
    }
    
    public var body: some View {
        GeometryReader { gr in
            if isScrollable {
                ScrollView {
                    makeCollectionView(using: gr)
                        .padding(.horizontal, hPadding)
                        .padding(.vertical, vPadding)
                }
            } else {
                makeCollectionView(using: gr)
                    .padding(.horizontal, hPadding)
                    .padding(.vertical, vPadding)
            }
        }
    }
    
    private func makeCollectionView(using gr: GeometryProxy) -> some View {
        
        VStack(alignment: .leading, spacing: self.vSpacing) {
            ForEach(0..<self.vRowCount) { index in
                HStack(spacing: self.hSpacing) {
                    
                    ForEach(0..<columns) { column in
                        
                        if data.count > index*columns + column {
                            self.content(self.data[index*columns + column])
                                .frame(width: (gr.size.width - hPadding - hSpacing*2) / CGFloat(columns),
                                       height: (gr.size.width - hPadding - hSpacing*2) / CGFloat(columns))
                        }
                    }
                }
            }
        }
    }
    
}

struct QGridTestView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let dataList:[NewTestData] = [
            NewTestData(name: "김광수1"),
            NewTestData(name: "김광수2"),
            NewTestData(name: "김광수3"),
            NewTestData(name: "김광수4"),
            NewTestData(name: "김광수5"),
            NewTestData(name: "김광수6"),
            NewTestData(name: "김광수7"),
            NewTestData(name: "김광수8"),
            NewTestData(name: "김광수9"),
            NewTestData(name: "김광수0")
        ]
        
        QGridTestView(dataList, columns: 2) { data in
            VStack {
                Image("wwdc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(data.name)
                    .font(.title)
            }
        }
    }
}
