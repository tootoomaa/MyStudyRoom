//
//  ContentView.swift
//  ARKitVision
//
//  Created by 김광수 on 2021/12/13.
//

import SwiftUI
import ARKit
import Vision

enum HandPose: String {
    case rock
    case paper
    case none
}

struct ArWithVisionView: View {
    
    @State var handPose: HandPose = .none
    
    var body: some View {
        ZStack {
            
            ARKitWithVisionView(handPose: $handPose)    // AR + VISION
        
            DisplayInfomationView(handPose: handPose)   // 인식 결과
            
        } //: ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArWithVisionView()
    }
}

struct ARKitWithVisionView: UIViewRepresentable {
    
    @Binding var handPose: HandPose
    let sceneView = ARSCNView()
    let configure = ARWorldTrackingConfiguration()
    
    func makeUIView(context: Context) -> some ARSCNView {
        self.sceneView.delegate = context.coordinator
        self.sceneView.session.delegate = context.coordinator
        self.sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.sceneView.session.run(configure)
        
        // AR Test Options
        let text = SCNText(string: "Test", extrusionDepth: 1.0)
        text.firstMaterial?.diffuse.contents = UIColor.blue
        let textNode = SCNNode(geometry: text)
        textNode.scale = SCNVector3(x: 0.02, y: 0.02, z: 0.02)
        textNode.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(textNode)
        
        return self.sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> ARKitWithVisionView.Coordinator {
        return ARKitWithVisionView.Coordinator(handPose: $handPose)
    }
}

extension ARKitWithVisionView {
    
    class Coordinator: NSObject, ARSCNViewDelegate, ARSessionDelegate {
        
        // MARK: - Controller
        @Binding var handPose: HandPose
        let paperConfidence: VNConfidence = 0.5
        let rockConfidence: VNConfidence = 0.5
        
        // 비전 요청을 통해 분석할 픽셀 버퍼
        private var currentBuffer: CVPixelBuffer?
        // 비전 요청을 실행할 큐 (Serial queue : 들어온 순서대로 처리)
        private let visionQueue = DispatchQueue(label: "serialVisionQueue")
        
        init(handPose: Binding<HandPose> ) {
            self._handPose = handPose
        }
        
        // Vision Hand Grip activity request and model
        private lazy var handGripReqeust: VNCoreMLRequest = {
            do {
                let model = try Rp(configuration: MLModelConfiguration()).model
                let mlModel = try VNCoreMLModel(for: model)
                let request = VNCoreMLRequest(model: mlModel) { [unowned self] (finishedReq, err) in
                    
                    guard let results = finishedReq.results,
                          let firstObservation = results.first as? VNRecognizedObjectObservation else {
                              print("Can not find Hand")
                              return
                          }
                    
                    if firstObservation.labels[0].identifier == "paper"
                        && firstObservation.confidence > paperConfidence {
                        DispatchQueue.main.async {
                            self.handPose = .paper
                        }
                        print("Paper")
                        return
                    }
                    
                    if firstObservation.labels[0].identifier == "rock"
                        && firstObservation.confidence > rockConfidence {
                        DispatchQueue.main.async {
                            self.handPose = .rock
                        }
                        print("Rock")
                        return
                    }
                    
                    self.handPose = .none
                }
                return request
            } catch {
                fatalError("Failed to load vision ML Model: \(error)")
            }
        }()
        
        // AR Session Start
        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            guard currentBuffer == nil, case .normal = frame.camera.trackingState else { return }
            self.currentBuffer = frame.capturedImage        // 버퍼 저장
            classifyCurrentImage()                          // 버퍼 분석 By VNImageRequestHandler
        }
        
        private func classifyCurrentImage() {
            // Most computer vision tasks are not rotation agnostic so it is important to pass in the orientation of the image with respect to device.
//            let orientation = CGImagePropertyOrientation(UIDevice.current.orientation)
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: currentBuffer!, orientation: .up)
            visionQueue.async {
                do {
                    // Release the pixel buffer when done, allowing the next buffer to be processed.
                    defer { self.currentBuffer = nil }
                    try requestHandler.perform([self.handGripReqeust])
                } catch {
                    print("Error: Vision request failed with error \"\(error)\"")
                }
            }
        }
    }
}
