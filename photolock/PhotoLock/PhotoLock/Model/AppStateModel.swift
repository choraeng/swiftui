//
//  AppStateModel.swift
//  PhotoLock
//
//  Created by 조영훈 on 2021/11/02.
//

import Foundation
import LocalAuthentication

enum PasswordOption: Int, Codable {
    case digit_4
    case digit_6
    case string
}

struct AppStateModel: Identifiable, Codable {
    var id = UUID()
    var isLock: Bool = false
    var isBio: Bool = false
    var password: String = ""
    var passwordType: PasswordOption = .digit_4
    
    init(){
        isLock = false
        isBio = false
        password = ""
        passwordType = .digit_4
    }
}

final class AppLockModel: ObservableObject {
    @Published var isLock: Bool = false // 앱 잡금 유무
    @Published var isBio: Bool = false // 앱 잠금 시 페이스 아이디 유무
    @Published var password: String = "" // 앱 패스워드
    @Published var password_type: PasswordOption = .digit_4 // 패스워드 타입
    
    @Published var isAppUnlocked: Bool = false // 현재 앱 잠금 해제 유무
    
    @Published var isUnloking: Bool = false // 페이스 인식 딜레이를 없애기 위해
    
    @Published var lockTime = Date() // 풀려야하는 시간
    
    @Published var emailTime = Date() // 이메일 인증 시간
    @Published var sendedEmail = "" // 이메일 인증 시간
    
    init() {
        getAppLockState()
    }
    
    // 앱 잠금 온
    func enableAppLock(pw: String, type: PasswordOption) {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLock.rawValue)
        self.isLock = true
        
        UserDefaults.standard.set(pw, forKey: UserDefaultsKeys.password.rawValue)
        self.password = pw
        
        if let encoded = try? JSONEncoder().encode(type) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.password_type.rawValue)
        }
        self.password_type = type

    }
    
    // 앱 잠금 오프
    func disableAppLock() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLock.rawValue)
        self.isLock = false
        
        UserDefaults.standard.set("", forKey: UserDefaultsKeys.password.rawValue)
        self.password = ""
        
        if let encoded = try? JSONEncoder().encode(PasswordOption.digit_4) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.password_type.rawValue)
        }
        self.password_type = PasswordOption.digit_4
    }
    
    // 앱 잠금 유무 갯
    func getAppLockState() {
        isLock = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLock.rawValue)
        isBio = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isBio.rawValue)
        password = UserDefaults.standard.string(forKey: UserDefaultsKeys.password.rawValue) ?? ""
        if let appstate = UserDefaults.standard.data(forKey: UserDefaultsKeys.password_type.rawValue) {
            if let decoded = try? JSONDecoder().decode(PasswordOption.self, from: appstate) {
                password_type = decoded
            }
        }
        if let _lockTime = UserDefaults.standard.object(forKey: UserDefaultsKeys.lock_time.rawValue){
            lockTime = _lockTime as! Date
        }
//        lockTime = Date()
    }
    
    func setAppLock(pw: String, type: PasswordOption) {
        self.enableAppLock(pw: pw, type: type)
        
        let laContext = LAContext()
        // 바이오 가능하면
        if checkIfBioMetricAvailable() {
            let reason = "Provice Touch ID/Face ID to enable App Lock"
            
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isBio.rawValue)
                        self.isBio = true
                        self.isAppUnlocked = true
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    func setLockTime(date: Date){
        self.lockTime = date
        UserDefaults.standard.set(date, forKey: UserDefaultsKeys.lock_time.rawValue)
    }
    
    func getEmailTime() {
        if emailTime < Date() {
            if let _emailTime = UserDefaults.standard.object(forKey: UserDefaultsKeys.email_verify.rawValue){
                emailTime = _emailTime as! Date
            }
        }
        
        if let temp = UserDefaults.standard.object(forKey: UserDefaultsKeys.email.rawValue){
            sendedEmail = temp as! String
        }
    }
    
    func setEmailTime(date: Date, email: String){
        self.emailTime = date
        UserDefaults.standard.set(date, forKey: UserDefaultsKeys.email_verify.rawValue)
        
        self.sendedEmail = email
        UserDefaults.standard.set(email, forKey: UserDefaultsKeys.email.rawValue)
    }
    
    func disableBio() {
        let reason = "Provice Touch ID/Face ID to disable App Lock"
        let laContext = LAContext()
        
        laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
            if success {
                DispatchQueue.main.async {
//                    self.enableAppLock()
                    self.isBio = false
                    self.isAppUnlocked = true
                }
            } else {
                if let error = error {
                    DispatchQueue.main.async {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // 폰이 바이오 되는지 확인
    func checkIfBioMetricAvailable() -> Bool {
        var error: NSError?
        let laContext = LAContext()
        
        let isBimetricAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error {
            print(error.localizedDescription)
        }
        
        return isBimetricAvailable
    }
    
    // 앱 잠금설정 변경
    func appLockStateChange(appLockState: Bool) {
        let laContext = LAContext()
        // 바이오 가능하면
        if checkIfBioMetricAvailable() {
            var reason = ""
            if appLockState {
                // 지문용 안내 문
                reason = "Provice Touch ID/Face ID to enable App Lock"
            } else {
                reason = "Provice Touch ID/Face ID to disable App Lock"
            }
            
            
            laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    if appLockState {
                        DispatchQueue.main.async {
//                            self.enableAppLock()
                            self.isAppUnlocked = true
                        }
                    } else {
                        DispatchQueue.main.async {
//                            self.disableAppLock()
                            self.isAppUnlocked = true
                        }
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    // 앱 잠금해제
    func appLockValidation(complete: @escaping () -> Void){
        let laContext = LAContext()
        if checkIfBioMetricAvailable() {
            let reason = "Enable App Lock"
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async {
//                        self.isAppUnlocked = true
//                    return true
                        complete()
                    }
                } else {
                    if let error = error {
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
//                        return false
                    }
                }
            }
        }
//        return false
    }
}

// 앱 상태 키 모음 for userdefaults
enum UserDefaultsKeys: String {
    case isLock
    case isBio
    case password
    case password_type
    case lock_time
    case email_verify
    case email
}

