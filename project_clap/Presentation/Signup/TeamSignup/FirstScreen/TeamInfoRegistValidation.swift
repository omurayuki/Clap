import Foundation

enum TeamInfoRegistValidationResult {
    case ok
    case empty
    case underText
    case overText
}

extension TeamInfoRegistValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct TeamInfoRegistValidation {
    static func validateIsUnder(team: String) -> TeamInfoRegistValidationResult {
        guard team.count >= 3 else {
            return .underText
        }
        return .ok
    }
    
    static func validateIsOver(team: String) -> Bool {
        if team.count <= 20 {
            return TeamInfoRegistValidationResult.overText.isValid
        } else {
            return TeamInfoRegistValidationResult.ok.isValid
        }
    }
    
    static func validatePicker(position: String, year: String) -> TeamInfoRegistValidationResult {
        guard position != R.string.locarizable.empty() && year != R.string.locarizable.empty() else {
            return .empty
        }
        return .ok
    }
}
