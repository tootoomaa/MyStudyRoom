//
//  MySearchableView.swift
//  AysncImageTestApp
//
//  Created by 김광수 on 2021/12/04.
//

import SwiftUI

struct MyCustomerListView: View {
    
    let customer: [String]
    
    var body: some View {
        List(customer, id: \.self) { customer in
            Text(customer)
        }
    }
}

struct MySearchableView: View {
    
    let names = ["Alex", "John", "Jack", "Jerry"]
    @State private var text: String = ""
    
    var body: some View {
        
        NavigationView {
            MyCustomerListView(customer: names)
        }.searchable(text: $text) {
            ForEach(names.filter({$0.hasPrefix(text)}), id: \.self) { name in
                Text(name)
            }
        }.onSubmit {
            // perfrom the search
        }
    }
}

struct MySearchableView_Previews: PreviewProvider {
    static var previews: some View {
        MySearchableView()
    }
}
