import Foundation

enum MemberInfoRegisterValidationResult {
    case ok
    case empty
    case notMatchEmail
    case notMatchPass
    case overText
}

extension MemberInfoRegisterValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct MemberInfoRegisterValidation {
    static func validatePass(pass: String, rePass: String) -> MemberInfoRegisterValidationResult {
        guard pass == rePass else {
            return .notMatchPass
        }
        return .ok
    }
    
    static func validateEmail(email: String) -> MemberInfoRegisterValidationResult {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
        guard emailCheck.evaluate(with: email) else {
            return .notMatchEmail
        }
        return .ok
    }
    
    static func validateEmpty(name: String, mail: String, pass: String, rePass: String) -> MemberInfoRegisterValidationResult {
        guard name.count >= 3, mail.count >= 3, pass.count >= 3, rePass.count >= 3 else {
            return .empty
        }
        return .ok
    }
    
    static func validatePicker(position: String) -> MemberInfoRegisterValidationResult {
        guard position != R.string.locarizable.empty() else {
            return .empty
        }
        return .ok
    }
    
    static func validateIsOverName(name: String) -> Bool {
        if name.count <= 20 {
            return MemberInfoRegisterValidationResult.overText.isValid
        } else {
            return MemberInfoRegisterValidationResult.ok.isValid
        }
    }
    
    static func validateIsOverPass(pass: String) -> Bool {
        if pass.count <= 35 {
            return MemberInfoRegisterValidationResult.overText.isValid
        } else {
            return MemberInfoRegisterValidationResult.ok.isValid
        }
    }
}
