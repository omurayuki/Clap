import Foundation
import UIKit
import RxSwift
import RxCocoa

class ConfirmationTeamIdViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var recievedTeamId: String
    
    private lazy var confirmationTeamTitle: UILabel = {
        let label = UILabel()
        label.text = "あなたのチームはfarでお間違い無いですか？"
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.numberOfLines = ConfirmationTeamIdResources.View.titleNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmationTeamId: UILabel = {
        let label = UILabel()
        label.font = AppResources.FontResources.confirmationTeamIdFont
        label.textColor = AppResources.ColorResources.subShallowBlueColor
        label.addUnderLine(text: label.text)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.yes(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = ConfirmationTeamIdResources.View.confirmBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.cancel(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.layer.cornerRadius = ConfirmationTeamIdResources.View.confirmBtnCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(teamId: String) {
        self.recievedTeamId = teamId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationTeamId.text = recievedTeamId
        setupUI()
        setupViewModel()
    }
}

extension ConfirmationTeamIdViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.confirmation()
        view.addSubview(confirmationTeamTitle)
        confirmationTeamTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmationTeamTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(confirmationTeamId)
        confirmationTeamId.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmationTeamId.topAnchor.constraint(equalTo: confirmationTeamTitle.bottomAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(confirmBtn)
        confirmBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmBtn.topAnchor.constraint(equalTo: confirmationTeamId.bottomAnchor, constant: view.bounds.size.width / 3.5).isActive = true
        confirmBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(cancelBtn)
        cancelBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelBtn.topAnchor.constraint(equalTo: confirmBtn.bottomAnchor, constant: view.bounds.size.width / 9.5).isActive = true
        cancelBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupViewModel() {
        confirmBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.confirmBtn.bounce(completion: {
                    guard let navi = self?.navigationController else { return }
                    navi.pushViewController(MemberInfoRegistViewController(), animated: true)
                })
            })
            .disposed(by: disposeBag)
        
        cancelBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.cancelBtn.bounce(completion: {
                    guard let navi = self?.navigationController else { return }
                    let vc = navi.viewControllers[navi.viewControllers.count - 4]
                    navi.popToViewController(vc, animated: true)
                })
            })
            .disposed(by: disposeBag)
    }
}
