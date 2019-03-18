import Foundation
import UIKit
import RxSwift
import RxCocoa
 
class TopViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var topTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.clap()
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.font = AppResources.FontResources.topLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.log_in(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TopResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signupBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.sign_up(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = TopResources.View.BtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
}

extension TopViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        view.addSubview(topTitle)
        topTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.height / 2.5).isActive = true
        view.addSubview(loginBtn)
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: topTitle.bottomAnchor, constant: view.bounds.size.height / 4).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(signupBtn)
        signupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: TopResources.Constraint.signupBtnTopConstraint).isActive = true
        signupBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupViewModel() {
        loginBtn.rx.tap
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.loginBtn.bounce(completion: {
                    guard let navi = self?.navigationController else { return }
                    navi.pushViewController(LoginViewCountroller(), animated: true)
                })
            })
            .disposed(by: disposeBag)
        signupBtn.rx.tap
            .throttle(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.signupBtn.bounce(completion: {
                    guard let navi = self?.navigationController else { return }
                    navi.pushViewController(SelectViewController(), animated: true)
                })
            })
            .disposed(by: disposeBag)
    }
}
