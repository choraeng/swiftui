//
//  CameraPreview.swift
//  CustomCameraApp
//
//  Created by Karen Mirakyan on 09.05.22.
//

import Foundation
import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
             AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    @EnvironmentObject var camera: CameraViewModel
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView() // UIView(frame: UIScreen.main.bounds)
        
        
        view.backgroundColor = .blue
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.session = camera.session
        view.videoPreviewLayer.connection?.videoOrientation = .portrait
        view.videoPreviewLayer.videoGravity = .resizeAspectFill

//        let view = UIView(frame: UIScreen.main.bounds)
//        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
//        camera.preview.bounds = CGRect(x: 0, y: 0, width: view.frame.width*2, height: view.frame.width / 3 * 4)
//        camera.preview.position=CGPoint(x: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width / 3 * 4).midX, y: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width / 3 * 4).midY);
////        camera.preview.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(camera.preview)
        
        
        camera.session.startRunning()
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
        
    }
}
