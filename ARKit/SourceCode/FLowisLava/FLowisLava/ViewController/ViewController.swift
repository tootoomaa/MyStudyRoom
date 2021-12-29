//
//  ViewController.swift
//  FLowisLava
//
//  Created by 김광수 on 2021/11/10.
//

import Foundation
import UIKit
import ARKit

class ViewController: UIViewController {
    
    let sceneView = ARSCNView()
    let configure = ARWorldTrackingConfiguration()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureScenceConfigure()
        configureScenceView()
//        let lavaNode = createLava()
//        self.sceneView.scene.rootNode.addChildNode(lavaNode)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    // MARK: - Configure
    private func configureView() {
        self.view.addSubview(sceneView)
        sceneView.frame = view.bounds
    }
    
    private func configureScenceConfigure() {
        self.configure.planeDetection = .horizontal
    }
    
    private func configureScenceView() {
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, .showFeaturePoints]
        self.sceneView.session.run(configure)
        self.sceneView.delegate = self
    }
    
    func createLava(planeAnchor: ARPlaneAnchor) -> SCNNode {
        let lavaNode = SCNNode(geometry: SCNPlane(width: CGFloat(planeAnchor.extent.x),
                                                  height: CGFloat(planeAnchor.extent.z)))
        
        lavaNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "concrete")!
        lavaNode.geometry?.firstMaterial?.isDoubleSided = true
        lavaNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
        lavaNode.eulerAngles = SCNVector3(90.degreesToRadians, 0, 0)
        return lavaNode
    }
    
    @objc func addCar(_ sender: Any) {
        let box = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        box.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
    }
}

// MARK: - ARSCNViewDelegate
extension ViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planAnchor = anchor as? ARPlaneAnchor else { return }
        let lava = createLava(planeAnchor: planAnchor)
        node.addChildNode(lava)
        print("New Flat surface detected, new ARPlanAnchor added")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planAnchor = anchor as? ARPlaneAnchor else { return }
        print("Updating floor's update Anchor \(planAnchor)")
        node.enumerateHierarchy { childNode, _ in
            childNode.removeFromParentNode()
        }
        let lavaNode = createLava(planeAnchor: planAnchor)
        node.addChildNode(lavaNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // 같은 anchor에 두가지 가 올라갈 경우
        guard anchor is ARPlaneAnchor else { return }
        node.enumerateHierarchy { childNode, _ in
            childNode.removeFromParentNode()
        }
    }
    
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}
