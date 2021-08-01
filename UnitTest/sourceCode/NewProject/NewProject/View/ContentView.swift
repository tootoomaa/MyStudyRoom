//
//  ContentView.swift
//  NewProject
//
//  Created by 김광수 on 2021/08/01.
//

import SwiftUI

struct ContentView: View {
    @State var itemList: [Item] = [] //["aaa", "Bbb", "ccc"]
    
    @State var selectionIndex: Int?
    
    @State var isPresentAddStringView: Bool = false
    @State var isPushDetailItemView: Bool = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(itemList) { item in
                    NavigationLink(
                        destination: DetailStringView(item: item),
                        label: { Text(item.string) })
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .toolbar{ EditButton() }
            .navigationTitle("String Box")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: plusButtonView())
        }
        .sheet(isPresented: $isPresentAddStringView) {
            AddStringView(isPresent: $isPresentAddStringView) {
                self.itemList.append($0)
            }
        }
    }
    
    private func plusButtonView() -> some View {
        Button(action: { isPresentAddStringView.toggle() },
               label: { Text("+").foregroundColor(.black) })
    }
    
    private func delete(index: IndexSet) {
        if let deleteitemIndex = index.first {
            itemList.remove(at: deleteitemIndex)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        itemList.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
