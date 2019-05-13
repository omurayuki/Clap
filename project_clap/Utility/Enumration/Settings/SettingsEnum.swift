import Foundation

enum SettingsSection: Int, CaseIterable {
    case account = 0
    case general
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
