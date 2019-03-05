import Foundation

enum RemindPassValidationResult {
    case ok
    case lessThanText
    case notMatchEmail
}

extension RemindPassValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct RemindPassValidation {
    static func validateEmail(email: String) -> RemindPassValidationResult {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        guard emailCheck.evaluate(with: email) else {
            return .notMatchEmail
        }
        return .ok
    }
    
    static func validateEmpty(email: String) -> RemindPassValidationResult {
        guard email.count >= 3 else {
            return .lessThanText
        }
        return .ok
    }
}
