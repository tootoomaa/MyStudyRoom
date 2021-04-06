//
//  FaceViewController.swift
//  FaceTrackingTestApp
//
//  Created by 김광수 on 2021/03/17.
//

import Foundation
import UIKit
import ARKit

class FaceViewController: UIViewController {
    
    lazy var sceneView = ARSCNView()
    let testView = UIView()
    
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
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        
        print(faceAnchor.lookAtPoint.x*100)
        print(faceAnchor.lookAtPoint.y*100)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARFaceAnchor {
            
            print("얼굴 인식")
            
        }
        
    }
    
}
