import Foundation

enum TeamIdWriteValidationResult {
    case ok
    case lessThanText
    case empty
    case notMatch
}

extension TeamIdWriteValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

class TeamIdWriteValidation {
    static func validateEmpty(teamId: String) -> TeamIdWriteValidationResult {
        guard teamId.count != 0 else {
            return .empty
        }
        return .ok
    }
    
    static func validCharCount(teamId: String) -> TeamIdWriteValidationResult {
        guard teamId.count >= 3 else {
            return .lessThanText
        }
        return .ok
    }
    
    static func validMatch(teamId: String) -> TeamIdWriteValidationResult {
        //DBにあるかチェック
        guard "22222" == teamId else {
            return .notMatch
        }
        return .ok
    }
}
