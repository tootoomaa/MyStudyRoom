//
//  ARUIRepresen.swift
//  AR-Hoops
//
//  Created by 김광수 on 2022/03/30.
//

import Foundation
import SwiftUI
import ARKit

struct ARCustomView: UIViewRepresentable {
    
    @Binding var isHideDetectedString: Bool
    
    func makeUIView(context: Context) -> some ARSCNView {
        let configure = ARWorldTrackingConfiguration()
        configure.planeDetection = .horizontal
        
        let sceneView = ARSCNView()
        sceneView.session.delegate = context.coordinator
        sceneView.delegate = context.coordinator
        sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        
        sceneView.session.run(configure)
        sceneView.autoenablesDefaultLighting = true
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Update")
    }
    
    func makeCoordinator() -> Coordinator {
        return Self.Coordinator(isHideDetectedString: $isHideDetectedString)
    }
    
}

extension ARCustomView {
    class Coordinator: NSObject, ARSCNViewDelegate, ARSessionDelegate {
        
        @Binding var isHideDetectedString: Bool
        
        init(isHideDetectedString: Binding<Bool>) {
            self._isHideDetectedString = isHideDetectedString
            super.init()
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard anchor is ARPlaneAnchor else { return }
            print("anchor")
            self.isHideDetectedString = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isHideDetectedString = true
            }
        }
        
    }
}
