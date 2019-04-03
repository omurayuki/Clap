import UIKit

protocol IndicatorShowable {
    var activityIndicator: UIActivityIndicatorView { get }
    func showIndicator()
    func hideIndicator(completion: (() -> Void)?)
}

//UIを定義しているから、わざわざそれぞれのコントローラーで切り分ける必要はない？
extension IndicatorShowable where Self: UIViewController {
    func showIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.activityIndicator.backgroundColor = .gray
            self.activityIndicator.layer.cornerRadius = 6
            self.activityIndicator.center = self.view.center
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideIndicator(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            completion?()
        }
    }
}
