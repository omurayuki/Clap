import Foundation
import UIKit
import RxSwift
import RxCocoa
//validationであれば遷移, なければアラート
class TeamIdWriteViewController: UIViewController {
    
    private struct Constants {
        struct Constraint {
            static let noticeTeamTextWidthConstraint: CGFloat = 70
        }
        
        struct View {
            static let confirmBtnCornerRadius: CGFloat = 15
        }
    }
    
    private let disposeBag = DisposeBag()
    private var viewModel: TeamIdWriteViewModel?
    
    private lazy var noticeTeamTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_write_team_id()
        label.textColor = AppResources.ColorResources.baseColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var noticeTeamText: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.please_confirm()
        label.textColor = AppResources.ColorResources.baseColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamIdField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.team_id()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var confirmTeamIdBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(R.string.locarizable.confirm(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.baseColor
        button.layer.cornerRadius = Constants.View.confirmBtnCornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.team_id()
        viewModel = TeamIdWriteViewModel(teamIdField: teamIdField.rx.text.orEmpty.asObservable())
        setupUI()
        setupViewModel()
    }
}

extension TeamIdWriteViewController {
    private func setupUI() {
        view.addSubview(noticeTeamTitle)
        noticeTeamTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeTeamTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(noticeTeamText)
        noticeTeamText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noticeTeamText.topAnchor.constraint(equalTo: noticeTeamTitle.bottomAnchor, constant: view.bounds.size.width / 4).isActive = true
        noticeTeamText.widthAnchor.constraint(equalToConstant: view.bounds.size.width - Constants.Constraint.noticeTeamTextWidthConstraint).isActive = true
        view.addSubview(teamIdField)
        teamIdField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamIdField.topAnchor.constraint(equalTo: noticeTeamText.bottomAnchor, constant: view.bounds.size.width / 4.5).isActive = true
        teamIdField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
        view.addSubview(confirmTeamIdBtn)
        confirmTeamIdBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmTeamIdBtn.topAnchor.constraint(equalTo: teamIdField.bottomAnchor, constant: view.bounds.size.width / 3.5).isActive = true
        confirmTeamIdBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isConfirmBtnEnable
            .subscribe(onNext: { [weak self] isValid in
                self?.confirmTeamIdBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)
        
        confirmTeamIdBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let navi = self?.navigationController else { return }
                guard let teamId = self?.teamIdField.text else { return }
                let a = ConfirmationTeamIdViewController(teamId: teamId)
                navi.pushViewController(ConfirmationTeamIdViewController(teamId: teamId), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
