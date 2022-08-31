//
//  CameraXPN.swift
//  CustomCameraApp
//
//  Created by Karen Mirakyan on 09.05.22.
//


import SwiftUI

/**
 SwiftUI Photo and Video recording view.
 
# Permissions
To avoid unexpected crashes be sure enabled camera and audio access in your info.plist
 
# Funcionality
Tap to take image and hold the button to start recording view.
On the top left corner you can see flip camera icon which will toggle front-back cameras
 
# Code
```
CameraXPN(action: { url, data in
    print(url)
    print(data.count)
}, font: .subheadline, permissionMessgae: "Permission Denied")
```
 
 */
public struct CameraXPN: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var camera = CameraViewModel()
    
    let action: ((URL, Data) -> Void)
    let font: Font
    let permissionAlertMessage: String
    
    
    var retakeButtonBackground: Color
    var retakeButtonForeground: Color
    
    var backButtonBackground: Color
    var backButtonForeground: Color
    
    var closeButtonBackground: Color
    var closeButtonForeground: Color
    
    var takeImageButtonColor: Color
    var recordVideoButtonColor: Color
    
    var flipCameraBackground: Color
    var flipCameraForeground: Color
    
    
    var useMediaContent: String
    var useMediaButtonForeground: Color
    var useMediaButtonBackground: Color
    
    var videoAllowed: Bool
    let maxVideoDuration: Int
    
    
    /// Description
    /// - Parameters:
    ///   - action: action that returns url of our content with extension video.mov or photo.jpg
    ///   - font: font you need to present user media button
    ///   - permissionMessgae: a message that will be shown if video or audio access is denied
    ///   - retakeButtonBackground: retakeButton background description
    ///   - retakeButtonForeground: retake button image color
    ///   - backButtonBackground: backButton background color
    ///   - backButtonForeground: backButton  button image color
    ///   - closeButtonBackground: close button background color
    ///   - closeButtonForeground: close button image color
    ///   - takeImageButtonColor: take image button color
    ///   - recordVideoButtonColor: record video button color
    ///   - flipCameraBackground: flip camera button background
    ///   - flipCameraForeground: flip camera button image color
    ///   - useMediaContent: use media text that can be replaced
    ///   - useMediaButtonForeground: use media button text color
    ///   - useMediaButtonBackground: use media button background color
    ///   - videoAllowed: video can be allowed or not
    ///   - maxVideoDuration: set maximum duration of the video you want to record
    ///
    public init(action: @escaping ((URL, Data) -> Void), font: Font,
                permissionMessgae: String,
                retakeButtonBackground: Color = .white,
                retakeButtonForeground: Color = .black,
                
                backButtonBackground: Color = .white,
                backButtonForeground: Color = .black,
                
                closeButtonBackground: Color = .white,
                closeButtonForeground: Color = .black,
                
                takeImageButtonColor: Color = .white,
                recordVideoButtonColor: Color = .red,
                
                flipCameraBackground: Color = .white,
                flipCameraForeground: Color = .black,
                
                
                useMediaContent: String = "Use This Media",
                useMediaButtonForeground: Color = .black,
                useMediaButtonBackground: Color = .white,
                videoAllowed: Bool = true,
                maxVideoDuration: Int = 15) {
        
        self.action = action
        self.font = font
        self.permissionAlertMessage = permissionMessgae
        self.retakeButtonBackground = retakeButtonBackground
        self.retakeButtonForeground = retakeButtonForeground
        
        self.closeButtonBackground = closeButtonBackground
        self.closeButtonForeground = closeButtonForeground
        
        self.backButtonBackground = backButtonBackground
        self.backButtonForeground = backButtonForeground
        
        self.takeImageButtonColor = takeImageButtonColor
        self.recordVideoButtonColor = recordVideoButtonColor
        
        self.flipCameraBackground = flipCameraBackground
        self.flipCameraForeground = flipCameraForeground
        
        self.useMediaContent = useMediaContent
        self.useMediaButtonBackground = useMediaButtonBackground
        self.useMediaButtonForeground = useMediaButtonForeground
        
        self.videoAllowed = videoAllowed
        self.maxVideoDuration = maxVideoDuration
    }
    
    //MARK: button views
    var lightSwitch: some View {
        Button(action: {
            if camera.flashMode == .off {
                camera.flashMode = .on
            } else {
                camera.flashMode = .off
            }
        }, label: {
            Image(systemName: (camera.flashMode == .on) ? "bolt.fill" : "bolt.slash.fill")
                .font(.system(size: 20, weight: .medium, design: .default))
        })
        .accentColor((camera.flashMode == .on) ? .yellow : .white)
    }
    var captureButton: some View {
        Button(action: {
            camera.takePic()
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 65, height: 65, alignment: .center)
                )
        })
    }
    
    var capturedPhotoCancel: some View {
        Button(action: {
//            presentationMode.wrappedValue.dismiss()
            camera.retakePic()
        }, label: {
            Text("cancel")
        })
    }
    
    var cameraTypeSwitch: some View {
        HStack {
            if camera.cameraType == .video {
                Text("사진")
                    .opacity(0)
            }
            
            Button {
                withAnimation {
                    camera.cameraType = .video
                }
            } label: {
                Text("비디오")
                    .foregroundColor((camera.cameraType == .video) ? .yellow : .white)
            }
            
            Button {
                withAnimation {
                    camera.cameraType = .photo
                }
            } label: {
                Text("사진")
                    .foregroundColor((camera.cameraType == .photo) ? .yellow : .white)
            }
                        
            if camera.cameraType == .photo {
                Text("비디오")
                    .opacity(0)
            }
            
            
            
        }
        .frame(maxWidth: .infinity)
    }
    
    var flipCameraButton: some View {
        Button(action: {
            if camera.position == .back {
                camera.position = .front
            } else {
                camera.position = .back
            }
            
            camera.setUp()
        }, label: {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        })
    }
    
    var zoomView: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
        }
    }
    
    public var body: some View {
        GeometryReader { reader in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
    //            if camera.isTaken && camera.previewURL != nil{
    //                CameraContentPreview(url: camera.previewURL)
    //                    .ignoresSafeArea(.all, edges: .all)
    //            }else {
    //                CameraPreview()
    //                    .environmentObject(camera)
    //            }
                if camera.isTaken && camera.previewURL != nil{
                    CameraContentPreview(url: camera.previewURL)
                        .ignoresSafeArea(.all, edges: .all)
                }
                VStack {
                    HStack(alignment: .center) {
                        lightSwitch
                    }
                    
//                        .frame(width: reader.size.width, height: 100)
//                        .background(.black)
                
                    
//                    Spacer()
//                    Color.clear
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .border(.red, width: 5)
                    ZStack(alignment: .bottom) {
                        CameraPreview()
//                            .frame(width: reader.size.width, height: reader.size.width / 3 * 4)
    //                        .ignoresSafeArea(.all, edges: .all)
                            .environmentObject(camera)
                            .padding(.vertical, 10)
                        
                        zoomView
//                            .padding(.bottom, 20)
                    }
//                    .frame(width: reader.size.width, height: reader.size.width / 3 * 4)
                    .background(Color.red)
                    
                    
                    VStack {
                        cameraTypeSwitch
                        HStack {
                            capturedPhotoCancel
                            
                            Spacer()
                            
                            captureButton
                            
                            Spacer()
                            
                            flipCameraButton
                            
                        }
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .onAppear {
            camera.checkPermission()
            camera.checkAudioPermission()
        }.alert(isPresented: $camera.alert) {
            Alert(title: Text(NSLocalizedString("youFoundInterlocutor", comment: "")),
                  primaryButton: .default(Text(NSLocalizedString("goToSettings", comment: "")), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
                  secondaryButton: .cancel(Text(NSLocalizedString("cancel", comment: ""))))
        }.onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) { _ in
            if camera.recordedDuration <= Double(maxVideoDuration) && camera.isRecording {
                camera.recordedDuration += 0.01
            }
            
            if camera.recordedDuration >= Double(maxVideoDuration) && camera.isRecording {
                camera.stopRecording()
            }
        }
    }
}
