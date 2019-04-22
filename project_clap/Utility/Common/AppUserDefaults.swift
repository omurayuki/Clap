import Foundation
import KeychainAccess

struct AppUserDefaults {
    static func setTeamId(value: String) {
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: "teamId")
        userDefaults.synchronize()
    }
    
    static func getValue(keyName: String) -> String {
        let userDefaults: UserDefaults = UserDefaults.standard
        return userDefaults.string(forKey: keyName) ?? ""
    }
}
