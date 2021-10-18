//
//  OrderTotalView.swift
//  CoffeeOrderingApp
//
//  Created by 김광수 on 2021/10/17.
//

import SwiftUI

struct OrderTotalView: View {
    
    var total: Double
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Text(String(format: "$%.2f", self.total))
                .font(.title)
                .foregroundColor(Color.green)
            Spacer()
        }.padding(10)
    }
}

struct OrderTotalView_Previews: PreviewProvider {
    static var previews: some View {
        OrderTotalView(total: 45.67)
    }
}
