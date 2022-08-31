//
//  CameraViewModel.swift
//  CustomCameraApp
//
//  Created by Karen Mirakyan on 09.05.22.
//

import Foundation
import SwiftUI
import AVFoundation

enum cameramode {
    case photo
    case video
}

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate {
    
    @Published var isTaken: Bool = false
    @Published var alert: Bool = false
    @Published var session = AVCaptureSession()
    @Published var picOutput = AVCapturePhotoOutput()
    
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var position: AVCaptureDevice.Position = .back
    
    @Published var isSaved: Bool = false
    @Published var mediaData = Data(count: 0)
    
    @Published var video: Bool = false
    @Published var videoOutput = AVCaptureMovieFileOutput()
    
    @Published var isRecording: Bool = false
    @Published var previewURL: URL?
    
    @Published var recordedDuration: Double = 0
    
    @Published var recordPermission: AVAudioSession.RecordPermission = .undetermined
    
    
    // cho
    var photoWidth: CGFloat = 0
    var photoheight: CGFloat = 0
    
    @Published var currentZoomFactor: CGFloat = 1.0
    var lastScale: CGFloat = 1.0
    var videoInput: AVCaptureDeviceInput?
    @Published var flashMode: Bool = false
    @Published var cameraType: cameramode = .photo
    @Published var isTaked: Bool = false
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            alert.toggle()
            return
        default:
            return
        }
        
    }
    
    func checkAudioPermission() {
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { status in
                if status {
                    self.recordPermission = .granted
                } else {
                    self.recordPermission = .denied
                }
            }
            
        case .denied:
            self.recordPermission = .denied
        case .granted:
            self.recordPermission = .granted
            
            
        default:
            return
        }
        
    }
    
    func setUp() {
        if video {
            
            do {
                self.session.beginConfiguration()
                
                // remove all inputs and outputs from the session
                for input in session.inputs { session.removeInput(input) }
                for output in session.outputs { session.removeOutput(output) }
                
                let cameraDevice = bestDevice(in: position)
                //
                
                let cameraInput = try AVCaptureDeviceInput(device: cameraDevice)
                videoInput = cameraInput
                let audioDevice = AVCaptureDevice.default(for: .audio)
                let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
                
                if self.session.canAddInput(cameraInput) && self.session.canAddInput(audioInput) {
                    self.session.addInput(cameraInput)
                    self.session.addInput(audioInput)
                }
                
                if self.session.canAddOutput(self.videoOutput) {
                    self.session.addOutput(self.videoOutput)
                }
                
                
                self.session.commitConfiguration()
                
            } catch {
                print(error.localizedDescription)
            }
            
        } else {
            do {
                self.session.beginConfiguration()
                
                // remove all inputs and outputs from the session
                for input in session.inputs { session.removeInput(input) }
                for output in session.outputs { session.removeOutput(output) }
                
                let device = bestDevice(in: position)
                let input = try AVCaptureDeviceInput(device: device)
                videoInput = input
                
                if self.session.canAddInput(input) {
                    self.session.addInput(input)
                }
                
                if self.session.canAddOutput(self.picOutput) {
                    self.session.addOutput(self.picOutput)
                }
                
                self.session.commitConfiguration()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:
                                                                [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera],
                                                            mediaType: .video, position: .unspecified)
    
    func bestDevice(in position: AVCaptureDevice.Position) -> AVCaptureDevice {
        let devices = self.discoverySession.devices
        guard !devices.isEmpty else { fatalError("Missing capture devices.")}
        
        return devices.first(where: { device in device.position == position })!
    }
    
    // take and retake functions...
    
    func takePic() {
//        videoInput?.device.flashMode = .on
        DispatchQueue.global(qos: .userInteractive).async {
            var photoSettings = AVCapturePhotoSettings()
            
            // Capture HEIF photos when supported. Enable according to user settings and high-resolution photos.
            // TODO 사진 모드
            if  self.picOutput.availablePhotoCodecTypes.contains(.hevc) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
            }
            
            if self.videoInput!.device.isFlashAvailable {
                photoSettings.flashMode = self.flashMode ? .on : .off
            }
            
//            photoSettings.isHighResolutionPhotoEnabled = true
//            if !photoSettings.__availablePreviewPhotoPixelFormatTypes.isEmpty {
//                photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoSettings.__availablePreviewPhotoPixelFormatTypes.first!]
//            }
//
//            photoSettings.photoQualityPrioritization = .speed
            
            
            
            self.picOutput.capturePhoto(with: photoSettings, delegate: self)
            DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                self.isTaked.toggle()
                 }
                
                withAnimation {
                    self.isTaken.toggle()
                }
                
                
                // 0.35
            }
        }
    }
    
    func retakePic() {
        video = false
        recordedDuration = 0
        setUp()
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
//                withAnimation {
//                    self.isTaken.toggle()
                    self.isTaken = false
                    self.isTaked = false
                    self.mediaData = Data(count: 0)
                    self.previewURL = nil
//                }
            }
        }
    }
    
    func startRecordinng() {
        withAnimation {
            isRecording = true
        }
        
        let tempFile = NSTemporaryDirectory() + "video.mov"
        videoOutput.startRecording(to: URL(fileURLWithPath: tempFile), recordingDelegate: self)
    }
    
    func stopRecording() {
        withAnimation {
            isRecording = false
        }
        
        videoOutput.stopRecording()
        
        isTaken.toggle()
        isTaked.toggle()
        session.stopRunning()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.mediaData = imageData
        self.isTaken = true
        savePhoto()
    }
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        if error != nil {
            print(error?.localizedDescription)
            return
        }
        
        previewURL = outputFileURL
        self.isTaken = true
        
        do {
            try self.mediaData = Data(contentsOf: outputFileURL)
        } catch {
            print("error occurred")
        }
    }
    
    func savePhoto() {
        let inputImage = UIImage(data: mediaData)!
        
        let imageViewScale = max(inputImage.size.width / UIScreen.main.bounds.width,
                                    inputImage.size.height / UIScreen.main.bounds.height)

           // Scale cropRect to handle images larger than shown-on-screen size
           let cropZone = CGRect(x: 0,
                                 y: 0,
                                 width:  self.photoheight * imageViewScale,
                                 height: self.photoWidth * imageViewScale)

        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
            else {
                return
            }

            // Return image to UIImage
//            let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
        
        
        if let data = UIImage(cgImage: cutImageRef, scale: inputImage.imageRendererFormat.scale, orientation: inputImage.imageOrientation).jpegData(compressionQuality: 0.8) {
            let tempFile = NSTemporaryDirectory() + "photo.jpg"
            try? data.write(to: URL(fileURLWithPath: tempFile))
            self.previewURL = URL(fileURLWithPath: tempFile)
        }

        
        
        
//        if let uiImage = UIImage(data: mediaData) {
//            if let data = uiImage.jpegData(compressionQuality: 0.8) {
//                let tempFile = NSTemporaryDirectory() + "photo.jpg"
//                try? data.write(to: URL(fileURLWithPath: tempFile))
//                self.previewURL = URL(fileURLWithPath: tempFile)
//            }
//        }
    }
    
}

extension CameraViewModel {
    func setphotoFrame(width: CGFloat, height: CGFloat) {
        if self.photoheight == 0 {
            self.photoWidth = width
            self.photoheight = height
        }
    }
}

extension CameraViewModel {
    // zoom feature
    func setZoom(factor: CGFloat) {
        let delta = factor / lastScale
        lastScale = factor
        
        let newScale = min(max(currentZoomFactor * delta, 1), 5)
        
        zoom(newScale)
        currentZoomFactor = newScale
    }
    
    func zoom(_ zoom: CGFloat){
        let factor = zoom < 1 ? 1 : zoom
        let device = self.videoInput!.device
        
        do {
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
    }
        
    func zoomInitialize() {
        lastScale = 1.0
    }
    
    // flash
    func changFlash(){
        flashMode.toggle()
    }
}
