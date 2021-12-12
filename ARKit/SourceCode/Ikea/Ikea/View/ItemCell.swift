//
//  ItemCEll.swift
//  Ikea
//
//  Created by 김광수 on 2021/12/11.
//

import SwiftUI

struct ItemCell: View {
    let item: Item
    @Binding var selectedItem: Item?
    
    var body: some View {
        Text(item.title)
            .padding()
            .background(selectedItem?.id == self.item.id ? Color.green : Color.orange)
            .foregroundColor(.white)
            .cornerRadius(20)
    }
}

struct ItemCEll_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: Item(title: "Cup"), selectedItem: .constant(Item(title: "Cup")))
    }
}
