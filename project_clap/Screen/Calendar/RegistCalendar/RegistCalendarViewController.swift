import Foundation
import UIKit
import RxSwift
import RxCocoa

class RegistCalendarViewController: UIViewController {
    
    private lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "タイトル"
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDate: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 13)
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDate: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 13)
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startTime: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 24)
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endTime: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 24)
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var between: UILabel = {
        let label = UILabel()
        label.text = "〜"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wrapTimeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(startDate)
        stack.addArrangedSubview(startTime)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var endStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(endDate)
        stack.addArrangedSubview(endTime)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var totalTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(startStack)
        stack.addArrangedSubview(between)
        stack.addArrangedSubview(endStack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension RegistCalendarViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(wrapTimeView)
        wrapTimeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        wrapTimeView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        wrapTimeView.heightAnchor.constraint(equalToConstant: view.bounds.size.height / 4.5).isActive = true
        wrapTimeView.addSubview(titleField)
        titleField.topAnchor.constraint(equalTo: wrapTimeView.topAnchor, constant: 5).isActive = true
        titleField.leftAnchor.constraint(equalTo: wrapTimeView.leftAnchor, constant: 10).isActive = true
        titleField.rightAnchor.constraint(equalTo: wrapTimeView.rightAnchor, constant: -10).isActive = true
        wrapTimeView.addSubview(totalTimeStack)
        totalTimeStack.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10).isActive = true
        totalTimeStack.leftAnchor.constraint(equalTo: wrapTimeView.leftAnchor, constant: 10).isActive = true
        totalTimeStack.rightAnchor.constraint(equalTo: wrapTimeView.rightAnchor, constant: -10).isActive = true
        setupInsideStartStack()
        setupInsideEndStack()
        setupInsideTotalStack()
    }
    
    private func setupInsideStartStack() {
        
    }
    
    private func setupInsideEndStack() {
        
    }
    
    private func setupInsideTotalStack() {
        
    }
}

extension RegistCalendarViewController: UITextFieldDelegate {
    
}
