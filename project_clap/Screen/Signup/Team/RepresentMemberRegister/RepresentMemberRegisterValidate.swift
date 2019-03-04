import Foundation

enum RepresentMemberRegisterValidationResult {
    case ok
    case empty
    case notEmpty
    case notMatchEmail
    case notMatchPass
}

extension RepresentMemberRegisterValidationResult {
    var isValid: Bool {
        switch self {
        case .empty:
            return false
        case .notMatchPass:
            return false
        case .notMatchEmail:
            return false
        default:
            return true
        }
    }
}

struct RepresentMemberRegisterValidate {
    static func validatePass(pass: String, rePass: String) -> RepresentMemberRegisterValidationResult {
        guard pass == rePass else {
            return .notMatchPass
        }
        return .ok
    }
    
    static func validateEmail(email: String) -> RepresentMemberRegisterValidationResult {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        guard emailCheck.evaluate(with: email) else {
            return .notMatchEmail
        }
        return .ok
    }
    
    static func validateEmpty(name: String, mail: String, pass: String, rePass: String) -> RepresentMemberRegisterValidationResult {
        guard name.count >= 3, mail.count >= 3, pass.count >= 3, rePass.count >= 3 else {
            return .empty
        }
        return .notEmpty
    }
}
