import UIKit

final class AlertController {
    
    enum AlertType {
        case loginFailed
        case sendMailFailed
        case sendMailSuccess
        
        var title: String {
            switch self {
            case .loginFailed: return "失敗"
            case .sendMailFailed: return "失敗"
            case .sendMailSuccess: return "成功"
            }
        }
        
        var message: String {
            switch self {
            case .loginFailed: return "ログインに失敗しました"
            case .sendMailFailed: return "メールの送信に失敗しました"
            case .sendMailSuccess: return "メールを送信しました"
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
