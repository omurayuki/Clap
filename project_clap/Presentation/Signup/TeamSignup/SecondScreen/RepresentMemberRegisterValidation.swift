import Foundation

enum RepresentMemberRegisterValidationResult {
    case ok
    case empty
    case notMatchEmail
    case notMatchPass
    case overText
}

extension RepresentMemberRegisterValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct RepresentMemberRegisterValidation {
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
        guard name.count >= 3, mail.count >= 3, pass.count >= 10, rePass.count >= 10 else {
            return .empty
        }
        return .ok
    }
    
    static func validatePicker(position: String, year: String) -> RepresentMemberRegisterValidationResult {
        guard position != R.string.locarizable.empty() && year != R.string.locarizable.empty() else {
            return .empty
        }
        return .ok
    }
    
    static func validateIsOverName(name: String) -> Bool {
        if name.count <= 20 {
            return RepresentMemberRegisterValidationResult.overText.isValid
        } else {
            return RepresentMemberRegisterValidationResult.ok.isValid
        }
    }
    
    static func validateIsOverPass(pass: String) -> Bool {
        if pass.count <= 35 {
            return RepresentMemberRegisterValidationResult.overText.isValid
        } else {
            return RepresentMemberRegisterValidationResult.ok.isValid
        }
    }
}
