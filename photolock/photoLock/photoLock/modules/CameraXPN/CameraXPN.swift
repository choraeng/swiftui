//
//  CameraXPN.swift
//  CustomCameraApp
//
//  Created by Karen Mirakyan on 09.05.22.
//


import SwiftUI


// 찍은거 확인
// 다시 찍기, 사용하기
// 사진 다시 찍기 camera.retakepic()



public struct CameraXPN: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var camera = CameraViewModel()
    
    let action: ((URL, Data) -> Void)
    let maxVideoDuration: Int = 15
    
    @State var currentZoom: String = "1x"
    
    public init(action: @escaping ((URL, Data) -> Void)) {
        self.action = action
    }
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                if !camera.isTaked {
                    topFrame
                }
                
                ZStack {
                    if camera.isTaked {
                        CameraContentPreview(url: camera.previewURL)
//                            .ignoresSafeArea(.all, edges: .all)
                    } else {
                        CameraPreview()
                            .environmentObject(camera)
//                            .ignoresSafeArea(.all, edges: .all)
                            .gesture(MagnificationGesture()
                                        .onChanged({ val in
                                camera.setZoom(factor: val)
                            })
                                        .onEnded({ val in
                                camera.zoomInitialize()
                            })
                            )
                    }
                    
                    VStack(spacing: 0) {
                        cameraView
                        
                        bottomFrame
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

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
            .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}


extension CameraXPN {
    var flashButton: some View {
        Button(action: {
            camera.changFlash()
        }, label: {
            Image(systemName: camera.flashMode ? "bolt.fill" : "bolt.slash.fill")
                .font(.system(size: 20, weight: .medium, design: .default))
        })
            .accentColor(camera.flashMode ? .yellow : .white)
    }
    
    var topFrame: some View {
        
        HStack {
            if !camera.isTaked {
                flashButton
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 80)
        .background(.black)
    }
    
    
    var cameraView: some View {
        VStack(spacing: 0){
            Spacer()
            
            if !camera.isTaked {
                Button(action: {
                    camera.setZoom(factor: 0)
                    camera.zoomInitialize()
                }, label: {
                    Circle()
                        .foregroundColor(Color.black.opacity(0.5))
                        .frame(width: 45, height: 45, alignment: .center)
                        .overlay(
                            Text(currentZoom)
                                .foregroundColor(.white))
                })
                    .padding(.bottom, 10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .readSize { new in
            camera.setphotoFrame(width: new.width, height: new.height)
        }
        .onChange(of: camera.currentZoomFactor) { newValue in
            let digit: Double = pow(10, 1)
            let value = round(newValue * digit) / digit
            if value.truncatingRemainder(dividingBy: 1) == 0{
                currentZoom = Array(arrayLiteral: String(value))[0] + "x"
            }else {
                currentZoom = String(format: "%.1f", value) + "x"
            }
        }
    }
    
    var captureButton: some View {
        Button(action: {
            if camera.video {
                if camera.isRecording {
                    camera.stopRecording()
                }else {
                    if camera.recordPermission == .granted {
                        withAnimation {
                            camera.video = true
                            camera.setUp()
                            camera.startRecordinng()
                        }
                    }
                }
            } else {
                camera.takePic()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: camera.isRecording ? 20 : 100)
                    .scale(camera.isRecording ? 0.5 : 1)
                    .fill(camera.video ? Color.red : Color.white)
                    .frame(width: 52, height: 52)
                //                    .clipShape(Circle())
                
                
                Circle()
                    .stroke(Color.white, lineWidth: 5)
                    .frame(width: 65, height: 65)
            }
            //            Circle()
            //                .foregroundColor(.white)
            //                .frame(width: 80, height: 80, alignment: .center)
            //                .overlay(
            //                    Circle()
            //                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
            //                        .frame(width: 65, height: 65, alignment: .center)
            //                )
        })
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
    
    var bottomFrame: some View {
        ZStack{
            Color.black
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(camera.video ? 0.5 : 1)
            VStack(spacing: 10) {
                if camera.isTaked {
                    HStack(spacing: 10) {
                        Button {
                            camera.retakePic()
                        } label: {
                            Text("다시 찍기")
                                .foregroundColor(Color.white)
                        }
                        
                        Spacer()
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("취소")
                                .foregroundColor(Color.white)
                        }
                    }
                } else {
                    HStack(spacing: 10) {
                        if camera.video {
                            Text("사진")
                                .opacity(0)
                        }
                        
                        Button {
                            withAnimation {
                                camera.video.toggle()
                            }
                        } label: {
                            Text("비디오")
                                .foregroundColor(camera.video ? .yellow : .white)
                        }
                        
                        Button {
                            withAnimation {
                                camera.video.toggle()
                            }
                        } label: {
                            Text("사진")
                                .foregroundColor(camera.video ? .white : .yellow)
                        }
                        
                        if !camera.video {
                            Text("비디오")
                                .opacity(0)
                        }
                    }
                    
                    HStack(spacing: 0) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("취소")
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 45, height: 45, alignment: .center)
                        
                        Spacer()
                        
                        captureButton
                        
                        Spacer()
                        
                        flipCameraButton
                    }
                }
            }
        }
        
        .frame(width: UIScreen.main.bounds.width, height: camera.isTaked ? 100 : 150)
        //        .background(Color.black)
        //        .opacity(camera.video ? 0.8 : 1)
    }
}
