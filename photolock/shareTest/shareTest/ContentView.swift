//
//  ContentView.swift
//  shareTest
//
//  Created by 조영훈 on 2021/12/11.
//

import SwiftUI
import CoreData
import LinkPresentation

struct ContentView: View {
    var body: some View {
        Button {
            actionSheet()
        } label: {
            Image("test")
                .resizable()
                .aspectRatio(contentMode: .fit)
            //            .frame(width: 36, height: 36)
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://developer.apple.com/xcode/swiftui/") else { return }
        
        let imageShare = UIImage(named: "test")
        let textShare = "test"
        let activityVC = UIActivityViewController(activityItems: [imageShare], applicationActivities: nil)
//        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        
        let title = "타이트르니아루미ㅏㅇ너루"
        let text = "설며우만우리ㅏㅓㅜ"
        // set up activity view controller
        let textToShare: [Any] = [
            MyActivityItemSource(title: title, content: Image("test"))
        ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        
        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class MyActivityItemSource: NSObject, UIActivityItemSource {
    var title: String
    var content: Image
    
    init(title: String, content: Image) {
        self.title = title
        self.content = content
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return content
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let image = UIImage(named: "test")!
        let imageProvider = NSItemProvider(object: image)
        let metadata = LPLinkMetadata()
        metadata.imageProvider = imageProvider
        metadata.title = "ASDfadsf"
//        metadata.url = URL("http://apple.com")
        
//        metadata.title = "Description of image to share" // Preview Title
//        metadata.originalURL = urlOfImageToShare // determines the Preview Subtitle
//        metadata.url = urlOfImageToShare
//        metadata.imageProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
//        metadata.iconProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
        return metadata

    }
    
}
