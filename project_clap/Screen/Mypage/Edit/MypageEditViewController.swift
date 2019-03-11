import Foundation
import UIKit
import RxSwift
import RxCocoa

class MypageEditViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: MypageEditViewModel?
    
    private lazy var userPhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = MypageResources.View.userPhotoLayerCornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var userPhotoWrapView: CustomView = {
        let view = CustomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var belongTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.belong()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var belongTeamField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.belong()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var belongStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(belongTitle)
        stack.addArrangedSubview(belongTeamField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var positionTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.position()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var positionField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.position()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var positionStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(positionTitle)
        stack.addArrangedSubview(positionField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var mailTitle: UILabel = {
        let label = UILabel()
        label.text = R.string.locarizable.mail()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mailField: UITextField = {
        let field = UITextField()
        field.placeholder = R.string.locarizable.mail()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mailStack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(mailTitle)
        stack.addArrangedSubview(mailField)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var saveBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.setTitle(R.string.locarizable.save(), for: .normal)
        button.backgroundColor = AppResources.ColorResources.normalBlueColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInsideStack()
        viewModel = MypageEditViewModel(belongField: belongTeamField.rx.text.orEmpty.asObservable(), positionField: positionField.rx.text.orEmpty.asObservable(), mailField: mailField.rx.text.orEmpty.asObservable())
        setupViewModel()
    }
}

extension MypageEditViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = R.string.locarizable.edit()
        view.addSubview(userPhotoWrapView)
        userPhotoWrapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        userPhotoWrapView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        userPhotoWrapView.addSubview(userPhoto)
        userPhoto.centerXAnchor.constraint(equalTo: userPhotoWrapView.centerXAnchor).isActive = true
        userPhoto.topAnchor.constraint(equalTo: userPhotoWrapView.topAnchor, constant: MypageResources.Constraint.userPhotoTopConstraint).isActive = true
        userPhoto.bottomAnchor.constraint(equalTo: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.userPhotoBottomConstraint).isActive = true
        userPhoto.widthAnchor.constraint(equalToConstant: MypageResources.Constraint.userPhotoWidthConstraint).isActive = true
        userPhoto.heightAnchor.constraint(equalToConstant: MypageResources.Constraint.userPhotoHeightConstraint).isActive = true
        view.addSubview(belongStack)
        belongStack.topAnchor.constraint(equalTo: userPhotoWrapView.bottomAnchor, constant: MypageResources.Constraint.belongStackTopConstraint).isActive = true
        belongStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        belongStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
        view.addSubview(positionStack)
        positionStack.topAnchor.constraint(equalTo: belongStack.bottomAnchor, constant: MypageResources.Constraint.positionStackTopConstraint).isActive = true
        positionStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        positionStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
        view.addSubview(mailStack)
        mailStack.topAnchor.constraint(equalTo: positionStack.bottomAnchor, constant: MypageResources.Constraint.mailStackTopConstraint).isActive = true
        mailStack.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        mailStack.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 12).isActive = true
        view.addSubview(saveBtn)
        saveBtn.topAnchor.constraint(equalTo: mailStack.bottomAnchor, constant: view.bounds.size.height / 8).isActive = true
        saveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveBtn.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.5).isActive = true
    }
    
    private func setupInsideStack() {
        belongTitle.leftAnchor.constraint(equalTo: belongStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        positionTitle.leftAnchor.constraint(equalTo: positionStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        mailTitle.leftAnchor.constraint(equalTo: mailStack.leftAnchor, constant: view.bounds.size.width / 8).isActive = true
        belongTeamField.leftAnchor.constraint(equalTo: belongTitle.rightAnchor, constant: MypageResources.Constraint.belongTeamLeftConstraint).isActive = true
        positionField.leftAnchor.constraint(equalTo: positionTitle.rightAnchor, constant: MypageResources.Constraint.positionLeftConstraint).isActive = true
        mailField.leftAnchor.constraint(equalTo: mailTitle.rightAnchor, constant: MypageResources.Constraint.mailLeftConstraint).isActive = true
    }
    
    private func setupViewModel() {
        viewModel?.outputs.isSaveBtnEnable.asObservable()
            .subscribe(onNext: { [weak self] isValid in
                self?.saveBtn.isHidden = !isValid
            })
            .disposed(by: disposeBag)
    }
}
