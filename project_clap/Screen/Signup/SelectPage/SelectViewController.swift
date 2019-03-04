import Foundation
import UIKit
import RxSwift
import RxCocoa

class SelectViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var selectionTeamOrMemberTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.select_usage_type()
        label.textColor = AppResources.ColorResources.baseColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.team(), for: .normal)
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var memberRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.locarizable.member(), for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var btnStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(teamRegistBtn)
        stack.addArrangedSubview(memberRegistBtn)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
}

extension SelectViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.type()
        view.addSubview(selectionTeamOrMemberTitle)
        selectionTeamOrMemberTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectionTeamOrMemberTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.width / 2.5).isActive = true
        view.addSubview(btnStack)
        btnStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        teamRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 3.5).isActive = true
        teamRegistBtn.heightAnchor.constraint(equalToConstant: view.bounds.size.width / 3.5).isActive = true
        memberRegistBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 3.5).isActive = true
        memberRegistBtn.heightAnchor.constraint(equalToConstant: view.bounds.size.width / 3.5).isActive = true
        memberRegistBtn.leftAnchor.constraint(equalTo: teamRegistBtn.rightAnchor, constant: SelectResources.Constraint.memberRegistBtnLeftConstraint).isActive = true
    }
    
    private func setupViewModel() {
        teamRegistBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _  in
                guard let navi = self?.navigationController else { return }
                navi.pushViewController(TeamInfoRegistViewController(), animated: true)
            })
            .disposed(by: disposeBag)
        
        memberRegistBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _  in
                guard let navi = self?.navigationController else { return }
                navi.pushViewController(TeamIdWriteViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
