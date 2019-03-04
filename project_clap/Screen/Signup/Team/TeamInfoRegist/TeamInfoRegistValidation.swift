import Foundation

enum ValidationResult {
    case lessThanText
    case moreThanText
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .lessThanText:
            return false
        case .moreThanText:
            return true
        }
    }
}

struct TeamInfoRegistValidation {
    static func validate(teamId: String) -> ValidationResult {
        guard teamId.count >= 10 else {
            return .lessThanText
        }
        return .moreThanText
    }
}
