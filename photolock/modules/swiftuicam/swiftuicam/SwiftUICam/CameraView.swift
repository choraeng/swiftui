//
//  CameraView.swift
//  SwiftUICam
//
//  Created by Pierre Véron on 31.03.20.
//  Copyright © 2020 Pierre Véron. All rights reserved.
//

import SwiftUI
import AVFoundation

// MARK: CameraView
public struct CameraView: UIViewControllerRepresentable {
    @ObservedObject var events: UserEvents
    //To enable call to updateUIView() on change of UserEvents() bc there is a bug
    class RandomClass { }
    let x = RandomClass()
    
    private var applicationName: String
    private var preferredStartingCameraType: AVCaptureDevice.DeviceType
    private var preferredStartingCameraPosition: AVCaptureDevice.Position
    
    private var focusImage: String?
    
    private var pinchToZoom: Bool
    private var tapToFocus: Bool
    private var doubleTapCameraSwitch: Bool
    
    private var _x: CGFloat
    private var _y: CGFloat
    private var __y: CGFloat
    
    public init(events: UserEvents, applicationName: String, preferredStartingCameraType: AVCaptureDevice.DeviceType = .builtInWideAngleCamera, preferredStartingCameraPosition: AVCaptureDevice.Position = .back, focusImage: String? = nil, pinchToZoom: Bool = true, tapToFocus: Bool = true, doubleTapCameraSwitch: Bool = true,
                _x: CGFloat, _y: CGFloat, __y:CGFloat) {
        self.events = events
        
        self.applicationName = applicationName
        
        self.focusImage = focusImage
        self.preferredStartingCameraType = preferredStartingCameraType
        self.preferredStartingCameraPosition = preferredStartingCameraPosition
        
        self.pinchToZoom = pinchToZoom
        self.tapToFocus = tapToFocus
        self.doubleTapCameraSwitch = doubleTapCameraSwitch
        
        self._x = _x
        self._y = _y
        self.__y = __y
    }
    
    public func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController(events: events)
        
        cameraViewController.delegate = context.coordinator
        
        cameraViewController.applicationName = applicationName
        cameraViewController.preferredStartingCameraType = preferredStartingCameraType
        cameraViewController.preferredStartingCameraPosition = preferredStartingCameraPosition
        
        cameraViewController.focusImage = focusImage
        
        cameraViewController.pinchToZoom = pinchToZoom
        cameraViewController.tapToFocus = tapToFocus
        cameraViewController.doubleTapCameraSwitch = doubleTapCameraSwitch
        
        cameraViewController.setCroppingFrame(frame: CGRect(x: 0, y: __y, width: _x, height: _y))
        
        return cameraViewController
    }
    
    public func updateUIViewController(_ cameraViewController: CameraViewController, context: Context) {
        if events.didAskToCapturePhoto {
            cameraViewController.takePhoto()
        }
        
        if events.didAskToRotateCamera {
            cameraViewController.rotateCamera()
        }
        
        if events.didAskToChangeFlashMode {
            cameraViewController.changeFlashMode()
        }
        
        if events.didAskToRecordVideo || events.didAskToStopRecording {
            cameraViewController.toggleMovieRecording()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: Coordinator
    public class Coordinator: NSObject, CameraViewControllerDelegate {
        
        var parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        public func cameraSessionStarted() {
                print("Camera session started")
            }
            
        public func noCameraDetected() {
                print("No camera detected")
            }
            
        public func didRotateCamera() {
                parent.events.didAskToRotateCamera = false
            }
            
        public func didCapturePhoto() {
                parent.events.didAskToCapturePhoto = false
            }
            
        public func didChangeFlashMode() {
                parent.events.didAskToChangeFlashMode = false
            }
            
        public func didFinishProcessingPhoto(_ image: UIImage) {
                //Not yet implemented
            }
            
        public func didFinishSavingWithError(_ image: UIImage, error: NSError?, contextInfo: UnsafeRawPointer) {
                //Not yet implemented
            }
            
        public func didChangeZoomLevel(_ zoom: CGFloat) {
                print("New zoom value: \(zoom)")
            }
            
        public func didFocusOnPoint(_ point: CGPoint) {
                print("Focus on point \(point) made")
            }
            
        public func didStartVideoRecording() {
                print("Video recording started")
            }
            
        public func didFinishVideoRecording() {
                parent.events.didAskToRecordVideo = false
                parent.events.didAskToStopRecording = false
                print("Video recording finished")
            }
            
        public func didSavePhoto() {
                print("Save photo to library")
            }
            
        public func didChangeMaximumVideoDuration(_ duration: Double) {
        //        parent.events.maximumVideoDuration = duration
                print("Change maximumVideoDuration to \(duration)")
            }
    }
}





