import Foundation

enum LoginValidationResult {
    case ok
    case empty
    case notMatch
}

extension LoginValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct LoginValidation {
    static func validateEmpty(email: String, pass: String) -> LoginValidationResult {
        guard email.count != 0 && pass.count != 0 else {
            return .empty
        }
        return .ok
    }
}
