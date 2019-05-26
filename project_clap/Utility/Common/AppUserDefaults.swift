import Foundation
import KeychainAccess

struct AppUserDefaults {
    static func setValue(value: String, keyName: String, completion: (() -> Void)? = nil) {
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: keyName)
        userDefaults.synchronize()
        completion?()
    }
    
    static func getValue(keyName: String) -> String {
        let userDefaults: UserDefaults = UserDefaults.standard
        return userDefaults.string(forKey: keyName) ?? ""
    }
    
    static func removeValue(keyName: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: keyName)
        userDefaults.synchronize()
    }
}
