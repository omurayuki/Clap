import Foundation

enum TeamIdWriteValidationResult {
    case ok
    case lessThanText
    case empty
    case notFetchBelongData
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
    
    static func validMatch(teamId: String?) -> TeamIdWriteValidationResult {
        var descriptionString: String?
        SignupRepositoryImpl.fetchBelongData(teamId: teamId ?? "") { description in
            descriptionString = description
        }
        guard descriptionString != nil else {
            return .notFetchBelongData
        }
        return .ok
    }
}
