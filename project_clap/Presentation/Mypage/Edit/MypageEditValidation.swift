import Foundation

enum MypageEditValidationResult {
    case ok
    case empty
    case overText
}

extension MypageEditValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct MypageEditValidation {
    static func validationEmpty(belong: String, position: String, email: String) -> MypageEditValidationResult {
        guard belong.count > 2 && position.count != 0, email.count != 5 else {
            return .empty
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
    
    static func validateIsOverBelong(name: String) -> Bool {
        if name.count <= 20 {
            return MypageEditValidationResult.overText.isValid
        } else {
            return MypageEditValidationResult.ok.isValid
        }
    }
}
