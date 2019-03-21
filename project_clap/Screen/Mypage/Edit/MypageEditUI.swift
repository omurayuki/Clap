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
    var positionStack: CustomStackView { get }
    var mailTitle: UILabel { get }
    var mailField: UITextField { get }
    var mailStack: CustomStackView { get }
    var viewTapGesture: UITapGestureRecognizer { get }
    var saveBtn: UIButton { get }
    
    func setup(vc: UIViewController)
    func setupInsideStack(vc: UIViewController)
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
        vc.view.backgroundColor = .white
        vc.navigationItem.title = R.string.locarizable.edit()
        vc.view.addSubview(userPhotoWrapView)
        userPhotoWrapView.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor).isActive = true
        userPhotoWrapView.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        userPhotoWrapView.addSubview(userPhoto)
        userPhoto.centerXAnchor.constraint(equalTo: userPhotoWrapView.centerXAnchor).isActive = true
        userPhoto.topAnchor.constraint(equalTo: userPhotoWrapView.topAnchor, constant: MypageResources.Constraint.userPhotoTopConstraint).isActive = true
        userPhoto.bottomAnchor.constraint(equalTo: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.userPhotoBottomConstraint).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: MypageResources.Constraint.userPhotoWidthConstraint).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: MypageResources.Constraint.userPhotoHeightConstraint).isActive = true
        vc.view.addSubview(belongStack)
        belongStack.topAnchor.constraint(equalTo: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.belongStackTopConstraint).isActive = true
        belongStack.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        belongStack.heightAnchor.constraint(equalToConstant: vc.view.bounds.size.height / 12).isActive = true
        vc.view.addSubview(positionStack)
        positionStack.topAnchor.constraint(equalTo: belongStack.bottomAnchor, constant: MypageResources.Constraint.positionStackTopConstraint).isActive = true
        positionStack.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        positionStack.heightAnchor.constraint(equalToConstant: vc.view.bounds.size.height / 12).isActive = true
        vc.view.addSubview(mailStack)
        mailStack.topAnchor.constraint(equalTo: positionStack.bottomAnchor, constant: MypageResources.Constraint.mailStackTopConstraint).isActive = true
        mailStack.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width).isActive = true
        mailStack.heightAnchor.constraint(equalToConstant: vc.view.bounds.size.height / 12).isActive = true
        vc.view.addSubview(saveBtn)
        saveBtn.topAnchor.constraint(equalTo: mailStack.bottomAnchor, constant: vc.view.bounds.size.height / 8).isActive = true
        saveBtn.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        saveBtn.widthAnchor.constraint(equalToConstant: vc.view.bounds.size.width / 1.5).isActive = true
        
        vc.view.addGestureRecognizer(viewTapGesture)
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
}
