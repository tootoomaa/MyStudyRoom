//
//  FaceViewController.swift
//  FaceTrackingTestApp
//
//  Created by 김광수 on 2021/03/17.
//

import Foundation
import UIKit
import ARKit
import SwiftUI

class FaceViewController: UIViewController, ObservableObject {
    
    lazy var sceneView = ARSCNView()
    let testView = UIView()
    
    final internal lazy var faceNode = SCNNode()
    final private var faceDetectedTime:Date?
    
    @Published var test: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        configureNavigationBar()
        
        configureLayout()
        
        configureSceneView()
    }
    
    private func configureNavigationBar() {

        let appear = UINavigationBarAppearance()
        appear.backgroundColor = .clear
        appear.shadowImage = UIImage()
        appear.backgroundImage = UIImage()
        
//        INavigationBar.appearance().backgroundColor = .clear
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
        
        self.navigationController?.navigationBar.compactAppearance = appear
        self.navigationController?.navigationBar.standardAppearance = appear
        self.navigationController?.navigationBar.scrollEdgeAppearance = appear
    }
    
    private func configureLayout() {
        
        [sceneView].forEach {
            view.addSubview($0)
        }
        
        sceneView.frame = view.bounds
        
        testView.frame.size = CGSize(width: 60, height: 60)
    }
    
    private func configureSceneView() {
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true

        
        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        config.maximumNumberOfTrackedFaces = 1
        
        let option: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        
        DispatchQueue.main.async {
            self.sceneView.session.run(config, options: option)
        }
        
    }
    
}

extension FaceViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else { return nil }
        
        let faceGeometry = ARSCNFaceGeometry(device: device)
        faceNode = SCNNode(geometry: faceGeometry)
        
        faceNode.geometry?.firstMaterial?.fillMode = .lines
        faceNode.geometry?.firstMaterial?.transparency = 0.0
        
        return faceNode
    }
    
    final func checkTimeDifferences() {
        let currTime = Date()
        guard let prevDate = faceDetectedTime else { return }
        let elapsed = currTime.timeIntervalSince(prevDate)
        let ms = Int((elapsed.truncatingRemainder(dividingBy: 1)) * 1000)
        
        guard ms > 250 else { return }
        print("벗어난듯?")
//        faceDetectionDelegate?.detectedFace(detected: false)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        checkTimeDifferences()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        guard let faceAnchor = anchor as? ARFaceAnchor,
              let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            print("111111111111111111111111111111111111111111")
            return
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
        faceNode.transform = node.transform
        faceDetectedTime = Date()
        
        print("얼굴 인식")
//        print(faceAnchor.lookAtPoint.x*100)
//        print(faceAnchor.lookAtPoint.y*100)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        
        if anchor is ARFaceAnchor {
            
            print("얼굴 인식")
            
        }
        
    }
    
}
