//
//  CameraPreview.swift
//  CustomCameraApp
//
//  Created by Karen Mirakyan on 09.05.22.
//

import Foundation
import SwiftUI
import AVFoundation

public struct CameraPreview: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
             AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    @EnvironmentObject var camera: CameraViewModel
    
    public func makeUIView(context: Context) -> UIView {
        let view = VideoPreviewView() // UIView(frame: UIScreen.main.bounds)
        
        
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = camera.session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        
        
//        let view = UIView(frame: UIScreen.)
//
//        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
////        camera.preview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//        camera.preview.frame = view.frame
//
//        camera.preview.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(camera.preview)
        
        
        camera.session.startRunning()
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
