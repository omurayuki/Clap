import UIKit

final class AlertController {
    
    enum AlertType {
        case loginFailed
        case sendMailFailed
        case sendMailSuccess
        case overChar
        case logoutFailure
        case registDiarySuccess
        case registDiaryFailure
        case diaryFetchFailure
        case sendCommentFailure
        case fetchCommentfailure
        
        var title: String {
            switch self {
            case .loginFailed: return "失敗"
            case .sendMailFailed: return "失敗"
            case .sendMailSuccess: return "成功"
            case .overChar: return "メッセージ"
            case .logoutFailure: return "失敗"
            case .registDiarySuccess: return "成功"
            case .registDiaryFailure: return "失敗"
            case .diaryFetchFailure: return "失敗"
            case .sendCommentFailure: return "失敗"
            case .fetchCommentfailure: return "失敗"
            }
        }
        
        var message: String {
            switch self {
            case .loginFailed: return "ログインに失敗しました"
            case .sendMailFailed: return "メールの送信に失敗しました"
            case .sendMailSuccess: return "メールを送信しました"
            case .overChar: return "制限文字数を超過しています"
            case .logoutFailure: return "ログアウトに失敗しました"
            case .registDiarySuccess: return "保存しました"
            case .registDiaryFailure: return "保存に失敗しました"
            case .diaryFetchFailure: return "日記取得に失敗しました"
            case .sendCommentFailure: return "コメントの登録に失敗しました"
            case .fetchCommentfailure: return "コメントの取得に失敗しました"
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
