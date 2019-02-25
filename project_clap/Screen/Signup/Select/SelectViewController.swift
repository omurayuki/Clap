import Foundation
import UIKit
import RxCocoa
import RxSwift

class SelectViewController: UIViewController {
    
    private lazy var selectionTeamOrMemberTitle: UILabel = {
        let label = UILabel()
        label.text = "利用者タイプを選んでください"
        label.textColor = UIColor(hex: "eab60e")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle("チーム", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(showTeamRegister(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var memberRegistBtn: UIButton = {
        let button = UIButton()
        button.setTitle("メンバー", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(showMemberRegister(sender:)), for: .touchUpInside)
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
        view.backgroundColor = .white
        setupUI()
    }
}

extension SelectViewController {
    private func setupUI() {
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
        memberRegistBtn.leftAnchor.constraint(equalTo: teamRegistBtn.rightAnchor, constant: 20).isActive = true
    }
    
    @objc
    func showTeamRegister(sender: UIButton) {
        
    }
    
    @objc
    func showMemberRegister(sender: UIButton) {
        
    }
}
