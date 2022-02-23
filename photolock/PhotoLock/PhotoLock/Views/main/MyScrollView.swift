//
//  MyScrollView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/02/01.
//

import SwiftUI
import UIKit

struct MyScrollView<Content: View>: UIViewControllerRepresentable {
    @Binding var isOnlyView: Bool
    let content: Content

    func makeUIViewController(context: Context) -> ViewController {
        return ViewController(coordinator: context.coordinator, isOnlyView: $isOnlyView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIViewController(_ viewController: ViewController, context: Context) {
        viewController.update(content: self.content)
    }
    
    class ViewController: UIViewController, UIScrollViewDelegate {
        let coordinator: Coordinator
        @Binding var isOnlyView: Bool
        let scrollView = UIScrollView()
        
        private var hostedView: UIView { coordinator.hostingController.view! }
        
        private var contentSizeConstraints: [NSLayoutConstraint] = [] {
              willSet { NSLayoutConstraint.deactivate(contentSizeConstraints) }
              didSet { NSLayoutConstraint.activate(contentSizeConstraints) }
        }
        
        init(coordinator: Coordinator, isOnlyView: Binding<Bool>) {
            self.coordinator = coordinator
            _isOnlyView = isOnlyView
            super.init(nibName: nil, bundle: nil)
            self.view = scrollView

            scrollView.delegate = self
            scrollView.maximumZoomScale = 3.0
            scrollView.minimumZoomScale = 0.8
            scrollView.bouncesZoom = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
//            scrollView.backgroundColor = .black // debug
            
            /* Manual hostedView from SwiftUI */
            let hostedView = coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = false
            hostedView.alpha = 0
            scrollView.addSubview(hostedView)
            alignment()
            
            recenter()
            view.setNeedsUpdateConstraints()
        }
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented")}
        
        override func viewDidAppear(_ animated: Bool) {
            hostedView.sizeToFit()
            recenter()
            hostedView.alpha = 1
        }
                
        func update(content: Content) {
            coordinator.hostingController.rootView = content
            scrollView.setNeedsUpdateConstraints()
        }
        
        func alignment() { 
            NSLayoutConstraint.activate([
                hostedView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                hostedView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                hostedView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                hostedView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                hostedView.bounds.width >= hostedView.bounds.height ? hostedView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor) : hostedView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ])
        }
        
        func recenter() { // 안에 여백을 재 조정해서 가운데로 재 배치하는 함수
            let scrollViewSize = scrollView.bounds.size
            let contentViewSize = hostedView.frame.size // 내가 넘겨준 프레임의 크기
            let horizontalInset = contentViewSize.width < scrollViewSize.width ? (scrollViewSize.width - contentViewSize.width) / 2.0 : 0
            let verticalInset = contentViewSize.height < scrollViewSize.height ? (scrollViewSize.height - contentViewSize.height) / 2.0 : 0
            
            scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostedView
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            recenter()
            if scrollView.zoomScale == 0.8{
                withAnimation {
                    isOnlyView = false
                }
            }else {
                withAnimation {
                    isOnlyView = true
                }
            }
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
    }
}
