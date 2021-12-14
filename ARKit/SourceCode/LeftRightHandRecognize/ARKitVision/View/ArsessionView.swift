//
//  ArsessionView.swift
//  ARKitVision
//
//  Created by 김광수 on 2021/12/14.
//

import SwiftUI
import AVFoundation
import Vision

enum HandSide: String {
    case left
    case right
    case none
}

class HandChekcer: ObservableObject {
    @Published var handSide: HandSide = .none
    @Published var thumbTipPoint: CGPoint = CGPoint(x: 0, y: 0)
    @Published var middleMCPPoint: CGPoint = CGPoint(x: 0, y: 0)
}

struct ArsessionView: View {
    
    @ObservedObject var hand = HandChekcer()
    
    var body: some View {
        ZStack {
            ARSessionView(hand: hand)
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.height)
                .edgesIgnoringSafeArea(.all)
            
            Text(hand.handSide.rawValue)
                .font(.title)
                .foregroundColor(.red)
            
            Circle()
                .frame(width: 10, height: 10)
                .background(Color.blue)
                .position(hand.thumbTipPoint)

            Circle()
                .frame(width: 10, height: 10)
                .background(Color.red)
                .position(hand.middleMCPPoint)
        }
    }
}


struct ARSessionView: UIViewRepresentable {
    
    @ObservedObject var hand: HandChekcer
    
    private let videoDataOutputQueue = DispatchQueue( label: "CameraFeedOutput", qos: .userInteractive)
    let view = UIView()
    let session = AVCaptureSession()
    
    func makeUIView(context: Context) -> some UIView {
        
        // 카메라 설정 : 전면(.front) 후면(.back)
        if let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            if let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) {
                
                session.beginConfiguration()
                session.sessionPreset = AVCaptureSession.Preset.high
                session.canAddInput(deviceInput)
                session.addInput(deviceInput)
                
                let dataOutput = AVCaptureVideoDataOutput()
                if session.canAddOutput(dataOutput) {
                    session.addOutput(dataOutput)
                    dataOutput.alwaysDiscardsLateVideoFrames = true
                    dataOutput.setSampleBufferDelegate(context.coordinator, queue: videoDataOutputQueue)
                }
                
                session.commitConfiguration()
                
                let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                //                    videoPreviewLayer.videoGravity = .resizeAspectFill
                videoPreviewLayer.videoGravity = .resizeAspect
                videoPreviewLayer.connection?.videoOrientation = .portrait
                
                view.layer.insertSublayer(videoPreviewLayer, at: 0)     // 맨 앞(0번째)으로 가져와서 보이게끔 설정
                DispatchQueue.main.async {
                    videoPreviewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
                                                     height: UIScreen.main.bounds.height)
                }
            }
        }
        
        session.startRunning()
        return view
    }
    
    func makeCoordinator() -> ARSessionView.Coordinator {
        Coordinator(hand, view: view)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

extension ARSessionView {
    
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        
        @ObservedObject var hand: HandChekcer
        var view: UIView
        
        let handPoseRequest: VNDetectHumanHandPoseRequest = {
            var request = VNDetectHumanHandPoseRequest()
            request.maximumHandCount = 1
            return request
        }()
        
        init(_ hand: HandChekcer, view: UIView) {
            self.hand = hand
            self.view = view
        }
        
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            let handler = VNImageRequestHandler(cmSampleBuffer: samplxeBuffer, orientation: .up, options: [:])
            
            do {
                try handler.perform([handPoseRequest])
                
                guard let observation = handPoseRequest.results?.first else { setHandSide(.none); return }
                
                // Get points for Thumb and middle Finger
                let thumbPoints = try observation.recognizedPoints(.thumb)
                let middlePoints = try observation.recognizedPoints(.middleFinger)
                
                // Get points for closed with hand
                guard let thumbTipPoints = thumbPoints[.thumbTip],
                      let middleMCPPoints = middlePoints[.middleMCP] else { setHandSide(.none); return }
                
                // 낮은 신뢰도는 무시한다.
                guard thumbTipPoints.confidence > 0.5
                        && middleMCPPoints.confidence > 0.5 else { setHandSide(.none); return }
                
                DispatchQueue.main.async {
                    self.hand.thumbTipPoint = self.changeToCGPoint(thumbTipPoints)
                    self.hand.middleMCPPoint = self.changeToCGPoint(middleMCPPoints)
                }
                
                if self.hand.thumbTipPoint.x > self.hand.middleMCPPoint.x {        //
                    setHandSide(.left)
                    return
                } else if self.hand.thumbTipPoint.x < self.hand.middleMCPPoint.x {
                    setHandSide(.right)
                    return
                }
                
                print("\(hand.thumbTipPoint)\n")
                print("\(hand.middleMCPPoint)")
                
            } catch {
                print(error)
            }
        } //: captureOutput
        
        func setHandSide(_ handSide: HandSide) {
            DispatchQueue.main.async { [weak self] in
                self?.hand.handSide = handSide
            }
        }
        
        func changeToCGPoint(_ point: VNRecognizedPoint) -> CGPoint {
            let point = CGPoint(x: point.location.x, y: 1 - point.location.y)
            
            if let layer = view.layer.sublayers?.compactMap({ $0 as? AVCaptureVideoPreviewLayer }).first {
                return layer.layerPointConverted(fromCaptureDevicePoint: point)
            }
            
            return .zero
        }
        
    }
    
}

