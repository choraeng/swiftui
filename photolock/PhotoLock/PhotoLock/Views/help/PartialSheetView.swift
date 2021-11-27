////
////  PartialSheetView.swift
////  PhotoLock
////
////  Created by 조영훈 on 2021/11/23.
////
//
//import SwiftUI
//
//struct PartialSheetView: View {
//    @State var showSheet = false
//    var body: some View {
//        NavigationView{
//        Button {
//            print("sfsdf")
//            showSheet.toggle()
//        } label: {
//            Text("test")
//        }
//        .navigationTitle("title")
//        .partialSheet(showSheet: $showSheet) {
//            Text("adsf")
//        }
//        }
//    }
//}
//
//struct PartialSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        PartialSheetView()
//    }
//}
//
//
//extension View {
//    func partialSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping ()->SheetView)->some View {
//        
//        return self
//            .background(
//                PartialSheetHelper(sheetView: sheetView(), showSheet: showSheet)
//            )
//    }
//}
//
//
//struct PartialSheetHelper<SheetView: View>: UIViewControllerRepresentable {
//    var sheetView: SheetView
//    @Binding var showSheet: Bool
//    
//    let controller = UIViewController()
//    
//    func makeUIViewController(context: Context) -> some UIViewController {
//        controller.view.backgroundColor = .clear
//        
//        return controller
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        if showSheet {
//            let sheetController = CustomHostingController(rootView: sheetView)// UIHostingController(rootView: sheetView)
//            
//            uiViewController.present(sheetController, animated: true) {
//                DispatchQueue.main.async {
//                    self.showSheet.toggle()
//                }
//            }
//        }
//    }
//}
//
//
//class CustomHostingController<Content: View>: UIHostingController<Content>{
//    override func viewDidLoad() {
//        if let presentationController = presentationController as? UIPresentationController{
//            presentationController.detents = [
//                .medium(),
//                .large()
//            ]
//        }
//    }
//}
