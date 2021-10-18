//
//  AddOrderCoffeeView.swift
//  CoffeeOrderingApp
//
//  Created by 김광수 on 2021/10/17.
//

import SwiftUI

struct AddCoffeeOrderView: View {
    
    @ObservedObject private var addCoffeeOrderVM = AddCoffeeOrderViewModel()
    @Binding var isPresent: Bool
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Form {
                    Section(header: Text("Information").font(.body)) {
                        TextField("Enter name", text: self.$addCoffeeOrderVM.name)
                    }
                    
                    Section(header: Text("SELECT COFFEE").font(.body)) {
                        ForEach(addCoffeeOrderVM.coffeeList, id: \.name) { coffee in
                            CoffeeCellView(coffee: coffee,
                                           selection: self.$addCoffeeOrderVM.coffeeName)
                        }
                    }
                    
                    Section(header: Text("SELECT SIZE").font(.body),
                            footer: OrderTotalView(total: self.addCoffeeOrderVM.total),
                            content: {
                                Picker("", selection: self.$addCoffeeOrderVM.size) {
                                    Text("Samll").tag("Small")
                                    Text("Medium").tag("Medium")
                                    Text("Large").tag("Large")
                                }.pickerStyle(SegmentedPickerStyle())
                            })
                }
                
                HStack {
                    Button("Place Order") {
                        
                        self.addCoffeeOrderVM.placeOrder()
                        self.isPresent.toggle()
                        
                    }.padding(EdgeInsets(top: 12, leading: 100, bottom: 12, trailing: 100))
                    .foregroundColor(Color.white)
                    .background(Color(red: 46/255, green: 204/255, blue: 113/255))
                    .cornerRadius(10)
                }
                
            }
            .navigationBarTitle("Add Order")
        }
    }
}

struct AddCoffeeOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeOrderView(isPresent: .constant(true))
    }
}

struct CoffeeCellView: View {
    
    let coffee: CoffeeViewModel
    @Binding var selection: String
    
    var body: some View {
        HStack {
            Image(coffee.imageURL)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .cornerRadius(16)
            
            Text(coffee.name)
                .font(.title)
                .padding([.leading], 20)
            
            Image(systemName: self.selection == self.coffee.name ? "checkmark" : "")
                .padding()
        }
        .onTapGesture {
            self.selection = self.coffee.name
        }
    }
}
