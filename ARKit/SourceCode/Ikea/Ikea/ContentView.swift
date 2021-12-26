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
    @State var isDetectedPlane: Bool = false
    
    let items: [Item] = [Item(title: "cup"), Item(title: "candle"),
                         Item(title: "chair"), Item(title: "lamp")]
    
    var body: some View {
        ZStack {
            
            ArsceenViewController(selectedItem: $selectedItem,
                                  isDetectedPlane: $isDetectedPlane)
            
            VStack {
                
                Text("Detected Plane")
                    .font(.title)
                    .padding(.top, 100)
                    .opacity(isDetectedPlane ? 1 : 0)
                
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(items, id: \.id) { item in
                            ItemCell(item: item,
                                     selectedItem: $selectedItem)
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


// MARK: - Pre Views
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - UIView Representable - ArsceenViewController
struct ArsceenViewController: UIViewRepresentable {
    
    let configuration = ARWorldTrackingConfiguration()
    var sceneView = ARSCNView()
    @Binding var selectedItem: Item?
    @Binding var isDetectedPlane: Bool
    
    func makeUIView(context: Context) -> some ARSCNView {
        self.sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.delegate = context.coordinator
        sceneView.addGestureRecognizer(context.coordinator.tapGestureRecognizer)    // Add Tap Geusture
        sceneView.addGestureRecognizer(context.coordinator.pinchGestureRecognizer)  // Add Pinch Geusture
        sceneView.addGestureRecognizer(context.coordinator.longPressGestureRecognizer)
        context.coordinator.longPressGestureRecognizer.minimumPressDuration = 0.1
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(sceneView: self.sceneView,
                           selectedItem: $selectedItem,
                           isDetectedPlane: $isDetectedPlane)
    }
    
}

// MARK: - ArsceenViewController Coordinator
extension ArsceenViewController {
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        
        let sceneView: ARSCNView
        @Binding var selectedItem: Item?
        @Binding var isDetectedPlane: Bool
        lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        lazy var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        lazy var longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(rotated))
        
        init(sceneView: ARSCNView, selectedItem: Binding<Item?>, isDetectedPlane: Binding<Bool>) {
            self.sceneView = sceneView
            self._selectedItem = selectedItem
            self._isDetectedPlane = isDetectedPlane
        }
        
        @objc func tapped(sender: UITapGestureRecognizer) {
            guard let sceneView = sender.view as? ARSCNView else { return }
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
        
        @objc func pinched(sender: UIPinchGestureRecognizer) {
            guard let sceneView = sender.view as? ARSCNView else { return }
            let pinchLocation = sender.location(in: sceneView)
            let results = sceneView.hitTest(pinchLocation)
            
            guard !results.isEmpty,
                  let result = results.first else { print("Hit Test is empty"); return }
            
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            result.node.runAction(pinchAction)
            sender.scale = 1.0
        }
        
        @objc func rotated(sender: UILongPressGestureRecognizer) {
            guard let sceneView = sender.view as? ARSCNView else { return }
            let rotateLocation = sender.location(in: sceneView)
            let results = sceneView.hitTest(rotateLocation)
            
            guard !results.isEmpty,
                  let result = results.first else { print("Hit test is Empty, In Rotate"); return }
            
            if sender.state == .began {
                let rotateAtion = SCNAction.rotateBy(x: 0, y: 360.degreeToRadius, z: 0, duration: 1)
                let foreverAction = SCNAction.repeatForever(rotateAtion)
                result.node.runAction(foreverAction)
            } else if sender.state == .ended {
                result.node.removeAllActions()
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
        
        // MARK: - ARSCNViewDelegate
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARPlaneAnchor else { return } // self.isDetectedPlane = false; return }
            DispatchQueue.main.async {
                self.isDetectedPlane = true
                DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                    self.isDetectedPlane = false
                }
            }
        }
        
    } //: Coordiantor
}

extension Int {
    var degreeToRadius: Double { return Double(self) * .pi / 180 }
}
