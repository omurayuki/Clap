import Foundation

enum DraftDiaryValidationResult {
    case ok
    case less
}

extension DraftDiaryValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct DraftDiaryValidation {
    static func validateText(text1: String, text2: String, text3: String, text4: String, text5: String, text6: String) -> DraftDiaryValidationResult {
        guard text1.count >= 15, text2.count >= 100, text3.count >= 100, text4.count >= 100, text5.count >= 100, text6.count >= 100 else {
            return .less
        }
        return .ok
    }
}
