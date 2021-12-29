//
//  ContentView.swift
//  Tca_Tutorial
//
//  Created by 김광수 on 2021/12/29.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack {
                    Button("−") { viewStore.send(.decrementButtonTapped) }
                    Text("\(viewStore.count)")
                    Button("+") { viewStore.send(.incrementButtonTapped) }
                }
                
                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                    send: .factAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}

struct FactAlert: Identifiable {
    var title: String
    var id: String { self.title }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(store: <#T##Store<AppState, AppAction>#>)
//    }
//}
