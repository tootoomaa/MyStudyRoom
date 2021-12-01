//
//  ContentView.swift
//  FLowisLava
//
//  Created by 김광수 on 2021/11/10.
//

import SwiftUI

struct ContentView: View {
    
    let vc = ViewControllerRepresetable()
    
    var body: some View {
        vc.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ViewControllerRepresetable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}
