//
//  ViewController.swift
//  ARworldTracking
//
//  Created by 김광수 on 2021/10/21.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    // MARK: - Properties
    let sceneView = ARSCNView()
    let configuration = ARWorldTrackingConfiguration()
    
    let addButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Add", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 20
        return bt
    }()
    
    let restButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Reset", for: .normal)
        bt.setTitleColor(.black, for: .normal)
        bt.backgroundColor = .orange
        bt.layer.cornerRadius = 20
        return bt
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSceneView()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dipose any Additional setup after loading the view
    }
    
    // MARK: - UI
    private func configureSceneView() {
        view.addSubview(sceneView)
        self.sceneView.frame = view.bounds
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                       ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    private func configureUI() {
        view.addSubview(addButton)
        addButton.frame = CGRect(x: 50, y: UIScreen.height-150, width: 100, height: 50)
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        
        view.addSubview(restButton)
        restButton.frame = CGRect(x: UIScreen.width - 150, y: UIScreen.height-150, width: 100, height: 50)
        restButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
}

// MARK: - Handler
extension ViewController {
    
    func restartSession() {
        self.sceneView.session.pause()

        guard self.sceneView.scene.rootNode.childNodes.isEmpty else {
            configureSessionAndRestartSession()
            return
        }
        
        self.sceneView.scene.rootNode.enumerateChildNodes { node, _ in
            node.removeFromParentNode()
        }
        
        configureSessionAndRestartSession()
    }
    
    private func configureSessionAndRestartSession() {
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                       ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private func randomNumders(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

// MARK: - Button action
extension ViewController {
    
    @objc private func add() {
        let node = SCNNode()
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        
        
        let newPath = UIBezierPath()
        newPath.move(to: CGPoint(x: 0.1, y: 0))         // 기준
        newPath.addLine(to: CGPoint(x: 0.13, y: 0.03))  // 오른쪽 위
        newPath.addLine(to: CGPoint(x: 0.11, y: 0.03))  // 왼쪽 약간
        newPath.addLine(to: CGPoint(x: 0.11, y: 0.07))  // 위로
        newPath.addLine(to: CGPoint(x: 0.09, y: 0.07))  // 왼쪽 약간
        newPath.addLine(to: CGPoint(x: 0.09, y: 0.03))  // 아래
        newPath.addLine(to: CGPoint(x: 0.07, y: 0.03))  // 왼쪽 약간
        newPath.addLine(to: CGPoint(x: 0.1, y: 0))
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addLine(to: CGPoint(x: 0.05, y: 0.05))     // 오른쪽 위
//        path.move(to: CGPoint(x: 0.05, y: 0.05))
//        path.addLine(to: CGPoint(x: -0.02, y: 0))      // 왼쪽 이동
//
//        path.move(to: CGPoint(x: 0.03, y: 0.05))
//        path.addLine(to: CGPoint(x: 0, y: 0.08))       // 위로
        
        
//        path.addLine(to: CGPoint(x: -0.008, y: 0))      // 왼족
//        path.addLine(to: CGPoint(x: 0, y: -0.015))      // 아래로
//        path.addLine(to: CGPoint(x: -0.006, y: 0))      // 왼쪽 이동
//        path.addLine(to: CGPoint(x: 0.01, y: -0.01))    // 오른쪽 아래 이동
        
        
        let shape = SCNShape(path: newPath, extrusionDepth: 0.02)
        node.geometry = shape
        
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
//        let x = randomNumders(firstNum: -0.1, secondNum: 0.1)
//        let y = randomNumders(firstNum: -0.1, secondNum: 0.1)
//        let z = randomNumders(firstNum: -0.1, secondNum: 0.1)
        
        node.position = SCNVector3(0, -0.1, -0.3)                         // 3차원 위치를 지정함 M
        self.sceneView.scene.rootNode.addChildNode(node)
    }
    
    @objc private func reset() {
        restartSession()
    }
}


