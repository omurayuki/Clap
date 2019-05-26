import UIKit

protocol IndicatorShowable {
    var activityIndicator: UIActivityIndicatorView { get }
    func showIndicator()
    func hideIndicator(completion: (() -> Void)?)
}

extension IndicatorShowable where Self: UIViewController {
    func showIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.style = .whiteLarge
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.activityIndicator.backgroundColor = UIColor(hex: "cccdce")
            self.activityIndicator.layer.cornerRadius = 13
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
