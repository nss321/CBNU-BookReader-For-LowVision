//
//  CameraPreviewView.swift
//  WhiteLens
//
//  Created by BAE on 5/5/24.
//

import SwiftUI
import AVFoundation


struct CameraPreviewView: UIViewRepresentable {
    
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        
        view.backgroundColor = .black
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
//        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        view.videoPreviewLayer.connection?.videoRotationAngle = 0
        
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
    
}

//#Preview {
//    CameraPreviewView()
//}
