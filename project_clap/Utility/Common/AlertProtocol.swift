import UIKit

final class AlertController {
    
    enum AlertType {
        case loginFailed
        case sendMailFailed
        case sendMailSuccess
        case overChar
        case logoutFailure
        
        var title: String {
            switch self {
            case .loginFailed: return "失敗"
            case .sendMailFailed: return "失敗"
            case .sendMailSuccess: return "成功"
            case .overChar: return "メッセージ"
            case .logoutFailure: return "失敗"
            }
        }
        
        var message: String {
            switch self {
            case .loginFailed: return "ログインに失敗しました"
            case .sendMailFailed: return "メールの送信に失敗しました"
            case .sendMailSuccess: return "メールを送信しました"
            case .overChar: return "制限文字数を超過しています"
            case .logoutFailure: return "ログアウトに失敗しました"
            }
        }
    }
    
    static func showAlertMessage(alertType: AlertType, viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(closeAction)
        viewController.present(alert, animated: true, completion: {
            completion?()
        })
    }
}
