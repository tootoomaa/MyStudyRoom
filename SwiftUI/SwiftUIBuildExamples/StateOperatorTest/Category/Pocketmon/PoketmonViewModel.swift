//
//  PoketmonViewModel.swift
//  StateOperatorTest
//
//  Created by 김광수 on 2021/03/29.
//

import SwiftUI

class PocketmonListViewModel: ObservableObject {
    
    @Published var pocketmons: [PocketmonViewModel]
    
    init() {
        
        let pocketmonList = [
            Pocketmon(id: 0, name: "Charmander", type: "Fire", color: .red),
            Pocketmon(id: 1, name: "Squirtle", type: "Water", color: .blue),
            Pocketmon(id: 2, name: "Bulbasaur", type: "Grass", color: .green),
            Pocketmon(id: 3, name: "Pikachu", type: "Electric", color: .yellow)
        ]
        
        self.pocketmons = pocketmonList.map(PocketmonViewModel.init)
    }
    
    func addPocketmon(new pocketmon: Pocketmon) {
        
        let vm = PocketmonViewModel(pocketmon: pocketmon)
        self.pocketmons.append(vm)
        
    }
}


struct PocketmonViewModel {
    
    let pocketmon: Pocketmon
    
    init(pocketmon: Pocketmon) {
        self.pocketmon = pocketmon
    }
    
    var id: Int {
        pocketmon.id
    }
    
    var name: String {
        pocketmon.name
    }
    
    var type: String {
        pocketmon.type
    }
    
    var color: Color {
        pocketmon.color
    }
}
