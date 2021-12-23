//
//  ContentView.swift
//  Ikea
//
//  Created by 김광수 on 2021/12/11.
//

import ARKit
import SwiftUI

struct ContentView: View {
    
    @State var selectedItem: Item?
    
    let items: [Item] = [Item(title: "cup"), Item(title: "candle"),
                         Item(title: "chair"), Item(title: "lamp")]
    
    var body: some View {
        ZStack {
            
            ArsceenViewController(selectedItem: $selectedItem)
            
            VStack {
                Spacer()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items, id: \.id) { item in
                            ItemCell(item: item, selectedItem: $selectedItem)
                                .onTapGesture {
                                    print("\(item.title)")
                                    self.selectedItem = item
                                }
                        }
                    }
                }
                .padding(30)
            } //: VStack
        } //: ZStack
        .edgesIgnoringSafeArea(.all)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ArsceenViewController: UIViewRepresentable {
    
    let configuration = ARWorldTrackingConfiguration()
    var sceneView = ARSCNView()
    @Binding var selectedItem: Item?
    
    func makeUIView(context: Context) -> some ARSCNView {
        self.sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.addGestureRecognizer(context.coordinator.tapGestureRecognizer)
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(sceneView: self.sceneView, selectedItem: $selectedItem)
    }
    
}

extension ArsceenViewController {
    
    class Coordinator {
        
        let sceneView: ARSCNView
        @Binding var selectedItem: Item?
        lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        
        init(sceneView: ARSCNView, selectedItem: Binding<Item?>) {
            self.sceneView = sceneView
            self._selectedItem = selectedItem
        }
        
        @objc func tapped(sender: UITapGestureRecognizer) {
            if let sceneView = sender.view as? ARSCNView {
                let tapLocation = sender.location(in: sceneView)
                
                guard let query = sceneView.raycastQuery(from: tapLocation, allowing: .existingPlaneGeometry, alignment: .horizontal) else {
                    print("Fail to make Query")
                    return
                }
                
                let results = sceneView.session.raycast(query)  // Query start
                if let result = results.first {
                    addItem(result: result)
                }
            }
        }
        
        func addItem(result: ARRaycastResult) {
            
            guard let selectedItem = selectedItem else {
                print("User didn't Select item")
                return
            }
            
            guard let scene = SCNScene(named: selectedItem.sceneItem) else {
                print("Fail to Find scene .scn file")
                return
            }
            
            // Test Option
//            let text = SCNText(string: "Test", extrusionDepth: 1.0)
//            text.firstMaterial?.diffuse.contents = UIColor.blue
//            let textNode = SCNNode(geometry: text)
//            textNode.scale = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
//            textNode.position = SCNVector3(0, 0, -1)
//            sceneView.scene.rootNode.addChildNode(textNode)
            
            if let node = scene.rootNode.childNode(withName: selectedItem.title, recursively: false) {
                let transform = result.worldTransform
                let thirdColumn = transform.columns.3
                
                node.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
                print(node.position)
                sceneView.scene.rootNode.addChildNode(node)
            }
        } //: AddItem
    } //: Coordiantor
}
