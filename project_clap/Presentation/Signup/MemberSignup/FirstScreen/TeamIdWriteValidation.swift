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
    
    var signupRepository = SignupRepositoryImpl()
    
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
    
    func validMatch(teamId: String, completion: ((TeamIdWriteValidationResult) -> Void)? = nil) {
        signupRepository.fetchBelongData(teamId: teamId) { description in
            if description == nil {
                guard let completion = completion else { return }
                completion(.notFetchBelongData)
                return
            }
            completion?(.ok)
        }
    }
}
