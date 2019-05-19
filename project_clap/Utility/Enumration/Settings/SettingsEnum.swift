import Foundation

enum SettingsSection: Int, CaseIterable {
    case account = 0
    case general = 1
    
    enum Account: Int {
        case passwordEdit = 0
        case emailEdit = 1
    }
    
    enum General: Int {
        case logout = 0
    }
}



extension SettingsSection {
    var title: String {
        switch self {
        case .account:
            return "アカウント"
        case .general:
            return "一般"
        }
    }
}
