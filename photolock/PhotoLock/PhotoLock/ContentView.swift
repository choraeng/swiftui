//
//  ContentView.swift
//  PhotoLock
//
//  Created by 조영훈 on 2022/01/29.
//

import SwiftUI
import CoreData
import CloudKit
import Photos


struct ContentView: View {
    @EnvironmentObject var appLockVM: AppLockModel
    @State private var bottomSheetShown = false
    
    @State var sheetTest = false
    
    @State var mainviewFortest = false
    
    
    @State var _img: [Image] = []
    
    var DEBUG = false
    
    var body: some View {
        if !DEBUG{
            //         잠금 설정이 되어있고, 잠금 해제가 안되어 있다면
            if appLockVM.isLock && !appLockVM.isAppUnlocked {
                UnlockAppView()
            }else { // if 화면 잠금
                if mainviewFortest {
                    MainView()
                } else {
                    NavigationView {
                        VStack {
                            NavigationLink {
                                tempPasswordView()
                            } label: {
                                Text("password")
                            }
                            .padding()
                            
                            
                            //                        Button {
                            //                            withAnimation(.easeInOut) {
                            //                                sheetTest.toggle()
                            //                            }
                            //                        } label: {
                            //                            Text("partial test")
                            //                        }
                            //                        .padding()
                            
                            Button("mainview") {
                                mainviewFortest.toggle()
                            }
                            .padding()
                            
                            //                        NavigationLink {
                            //                            tempPhotoView()
                            //                        } label: {
                            //                            Text("photo pick and share")
                            //                        }
                            //                        .padding()
                            
                        } // vstack
                        .navigationBarHidden(true)
                    }// navigationview
                    .customBottomSheet(isPresented: $sheetTest, title: "main") {
                        AnyView(
                            Text("Asdasdfasdff")
                                .foregroundColor(Color.red)
                                .frame(width: .infinity, height: 200)
                        )
                    }
                } // if
            } // if
            
        } else if DEBUG {
            ScrollView{
                Button("add"){
                    // set record
                    let record = CKRecord(recordType: "main")
                    record.setValuesForKeys([
                        "image": CKRecord.Reference(recordID: CKRecord.ID(recordName: "27F6F8D3-D502-49C2-9AD2-437FD76AAECB"), action: .deleteSelf)
                    ])
                    
                    // save
                    let container = CKContainer.default()
                    let database = container.privateCloudDatabase
                    
                    database.save(record) { record, error in
                        if let error = error {
                            // Handle error.
                            print(error)
                            return
                        }
                        print("save")
                    }
                }
                
                Button{
                    CKContainer.default().accountStatus { accountStatus, error in
                        if accountStatus == .noAccount {
                            DispatchQueue.main.async {
                                let message =
                                    """
                                    Sign in to your iCloud account to write records.
                                    On the Home screen, launch Settings, tap Sign in to your
                                    iPhone/iPad, and enter your Apple ID. Turn iCloud Drive on.
                                    """
                                //                        let alert = UIAlertController(
                                //                            title: "Sign in to iCloud",
                                //                            message: message,
                                //                            preferredStyle: .alert)
                                //                        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                                //                        self.present(alert, animated: true)
                                print(message)
                            }
                        }
                        else {
                            // Save your record here.
                            //                        addItem(img: UIImage(named: "AppIcon")!)
                            getItem()
                        }
                    }
                    
                } label: {
                    Text("Asdf")
                }
                ForEach(0..<_img.count, id: \.self){ content in
                    _img[content]
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            } // scroll view
        }
        
    }
    
    func addItem(img: UIImage) -> Void{
        // set image
        let data = img.pngData(); // UIImage -> NSData, see also UIImageJPEGRepresentation
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        
        do {
            try data!.write(to: url!) // data!.writeToURL(url, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        
        // set record
        let record = CKRecord(recordType: "test")
        record.setValuesForKeys([
            "test1": "!23123",
            "test2": CKAsset(fileURL: url!)
        ])
        
        // save
        let container = CKContainer.default()
        let database = container.privateCloudDatabase
        
        database.save(record) { record, error in
            if let error = error {
                // Handle error.
                print(error)
                return
            }
            // Record saved successfully.
            print("save")
            do {
                try FileManager.default.removeItem(at: url!)
            } catch let e {
                print("Error deleting temp file: \(e)")
            }
            
        }
    }
    
    func getItem() -> Void {
        let container = CKContainer.default()
        let db = container.privateCloudDatabase
        //
        //        let record = CKRecord(recordType: "test")
        //        db.
        
        let argu = "asdf"
        let pred = NSPredicate(format: "memo == %@", argu)
        //        let argu = 1 //"49113628-D7E9-48F1-8EC8-EAE05EDCDF54"
        //        let pred = NSPredicate(format: "%K = %@", "___etag", argu)
        
        //        let sort = NSSortDescriptor(key: "image", ascending: true)
        let query = CKQuery(recordType: "Image", predicate: pred)
        //        query.sortDescriptors = [sort]
        
        
        //        let pred = NSPredicate(value: true)
        //        let sort = NSSortDescriptor(key: "test1", ascending: false)
        //        let query = CKQuery(recordType: "test", predicate: pred)
        //        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["image"]
        operation.resultsLimit = 10
        
        
        operation.recordFetchedBlock = { record in
            print(record.recordID.recordName)
            if record["image"] != nil {
                let temp = record["image"] as? CKAsset
                //                print(temp!)
                let assetsData = NSData(contentsOf: (temp?.fileURL!)!)
                //                _img.append(Image(uiImage: UIImage(data: assetsData! as Data)!))
            }
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            DispatchQueue.main.async {
                if let error = error {
                    //                            completion(.failure(error))
                    print(error)
                } else {
                    print("done")
                    //                            completion(.success(newShoe))
                }
            }
        }
        
        db.add(operation)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
