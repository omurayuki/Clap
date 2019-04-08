import Foundation
import UIKit

protocol MypageEditUI: UI {
    var userPhoto: UIImageView { get }
    var userPhotoWrapView: CustomView { get }
    var belongTitle: UILabel { get }
    var belongTeamField: UITextField { get }
    var belongStack: CustomStackView { get }
    var positionTitle: UILabel { get }
    var positionField: UITextField { get }
    var positionToolBar: UIToolbar { get }
    var positionStack: CustomStackView { get }
    var mailTitle: UILabel { get }
    var mailField: UITextField { get }
    var mailStack: CustomStackView { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var doneBtn: UIBarButtonItem { get }
    var saveBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func setupInsideStack(vc: UIViewController)
    func getPickerView(vc: UIViewController) -> UIPickerView
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController)
}

final class MypageEditUIImple: MypageEditUI {
    
    weak var viewController: UIViewController?
    
    private(set) var userPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = MypageResources.View.userPhotoLayerCornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private(set) var userPhotoWrapView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) var belongTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.belong()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var belongTeamField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.belong()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var belongStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var positionTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.position()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var positionField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.position()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var positionToolBar: UIToolbar = {
        let toolbarFrame = CGRect(x: 0, y: 0, width: UIViewController().view.frame.width, height: MemberInfoRegisterResources.View.toolBarHeight)
        let accessoryToolbar = UIToolbar(frame: toolbarFrame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryToolbar.items = [flexibleSpace]
        accessoryToolbar.barTintColor = UIColor.white
        return accessoryToolbar
    }()
    
    private(set) var positionStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private(set) var mailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.mail()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var mailField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.mail()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private(set) var mailStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private(set) var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    private(set) var doneBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        return button
    }()
    
    private(set) var saveBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = MypageEditResources.View.saveBtnLayerCornerRadius
        button.setTitle(R.string.locarizable.save(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

extension MypageEditUIImple {
    
    func setup(vc: UIViewController) {
        positionToolBar.items = [doneBtn]
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.edit()
        vc.view.addGestureRecognizer(viewTapGesture)
        vc.view.addSubview(userPhotoWrapView)
        userPhotoWrapView.addSubview(userPhoto)
        vc.view.addSubview(belongStack)
        vc.view.addSubview(positionStack)
        vc.view.addSubview(mailStack)
        vc.view.addSubview(saveBtn)
        
        userPhotoWrapView.anchor()
            .top(to: vc.view.safeAreaLayoutGuide.topAnchor)
            .width(constant: vc.view.bounds.size.width)
            .activate()
        
        userPhoto.anchor()
            .centerXToSuperview()
            .top(to: userPhotoWrapView.topAnchor, constant: MypageResources.Constraint.userPhotoTopConstraint)
            .bottom(to: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.userPhotoBottomConstraint)
            .width(constant: MypageResources.Constraint.userPhotoWidthConstraint)
            .height(constant: MypageResources.Constraint.userPhotoHeightConstraint)
            .activate()
        
        belongStack.anchor()
            .top(to: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.belongStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
        
        positionStack.anchor()
            .top(to: belongStack.bottomAnchor, constant: MypageResources.Constraint.positionStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
        
        mailStack.anchor()
            .top(to: positionStack.bottomAnchor, constant: MypageResources.Constraint.mailStackTopConstraint)
            .width(constant: vc.view.bounds.size.width)
            .height(constant: vc.view.bounds.size.height / 12)
            .activate()
        
        saveBtn.anchor()
            .top(to: mailStack.bottomAnchor, constant: vc.view.bounds.size.height / 8)
            .centerXToSuperview()
            .width(constant: vc.view.bounds.size.width / 1.5)
            .activate()
    }
    
    func setupInsideStack(vc: UIViewController) {
        belongStack.addArrangedSubview(belongTitle)
        belongStack.addArrangedSubview(belongTeamField)
        positionStack.addArrangedSubview(positionTitle)
        positionStack.addArrangedSubview(positionField)
        mailStack.addArrangedSubview(mailTitle)
        mailStack.addArrangedSubview(mailField)
        belongTitle.leftAnchor.constraint(equalTo: belongStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        positionTitle.leftAnchor.constraint(equalTo: positionStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        mailTitle.leftAnchor.constraint(equalTo: mailStack.leftAnchor, constant: vc.view.bounds.size.width / 8).isActive = true
        belongTeamField.leftAnchor.constraint(equalTo: belongTitle.rightAnchor, constant: MypageResources.Constraint.belongTeamLeftConstraint).isActive = true
        positionField.leftAnchor.constraint(equalTo: positionTitle.rightAnchor, constant: MypageResources.Constraint.positionLeftConstraint).isActive = true
        mailField.leftAnchor.constraint(equalTo: mailTitle.rightAnchor, constant: MypageResources.Constraint.mailLeftConstraint).isActive = true
    }
    
    func getPickerView(vc: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = vc as? UIPickerViewDataSource
        pickerView.delegate = vc as? UIPickerViewDelegate
        pickerView.backgroundColor = .white
        return pickerView
    }
    
    func setupToolBar(_ textField: UITextField, toolBar: UIToolbar, content: Array<String>, vc: UIViewController) {
        textField.inputView = getPickerView(vc: vc)
        textField.inputAccessoryView = toolBar
        textField.text = content[0]
    }
}
