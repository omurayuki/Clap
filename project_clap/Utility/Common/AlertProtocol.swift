import UIKit

final class AlertController {
    
    enum AlertType {
        case loginFailed
        
        var title: String {
            switch self {
            case .loginFailed: return "エラー"
            }
        }
        
        var message: String {
            switch self {
            case .loginFailed: return "ログインに失敗しました"
            }
        }
    }
    
    static func showAlertMessage(alertType: AlertType, viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertType.title, message: alertType.message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(closeAction)
        viewController.present(alert, animated: true, completion: {
            guard let completion = completion else { return }
            completion()
        })
    }
}
