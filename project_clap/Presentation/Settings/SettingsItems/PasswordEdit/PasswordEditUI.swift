import Foundation
import UIKit

protocol PasswordEditUI: UI {
    var currentPass: UILabel { get }
    var currentPassField: UITextField { get }
    var newPass: UILabel { get }
    var newPassField: UITextField { get }
    var newRePassFIeld: UITextField { get }
    var submitBtn: UIButton { get }
    
    func setup()
}

final class PasswordEditUIImpl: PasswordEditUI {
    
    var viewController: UIViewController?
    
    var currentPass: UILabel = {
        let label = UILabel()
        label.text = "現在のパスワード"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var currentPassField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "現在のパスワードを記入"
        return field
    }()
    
    var newPass: UILabel = {
        let label = UILabel()
        label.text = "新しいパスワード"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var newPassField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "新しいパスワードを記入"
        return field
    }()
    
    var newRePassFIeld: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "新しいパスワードを記入"
        return field
    }()
    
    var submitBtn: UIButton = {
        let button = UIButton()
        button.setTitle("変更", for: .normal)
        button.layer.cornerRadius = 15.5
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        return button
    }()
}

extension PasswordEditUIImpl {
    func setup() {
        guard let vc = viewController else { return }
        vc.view.backgroundColor = .white
        vc.navigationItem.title = "パスワード変更"
        let stack = setupStack()
        [stack, submitBtn].forEach { vc.view.addSubview($0) }
        stack.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor, constant: 20)
            .left(to: vc.view.leftAnchor, constant: 20)
            .right(to: vc.view.rightAnchor, constant: -20)
            .activate()
        
        submitBtn.anchor()
            .centerXToSuperview()
            .top(to: stack.bottomAnchor, constant: 50)
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
    
    func setupStack() -> UIStackView {
        return VerticalStackView(arrangeSubViews: [
                    VerticalStackView(arrangeSubViews: [
                        currentPass,
                        currentPassField
                    ], spacing: 15),
                    VerticalStackView(arrangeSubViews: [
                        newPass,
                        newPassField,
                        newRePassFIeld
                    ], spacing: 15)
                ], spacing: 35)
    }
}
