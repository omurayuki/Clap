import Foundation
import RxSwift

protocol LoginViewModelInput {
    var emailText: Observable<String> { get }
    var passText: Observable<String> { get }
}

protocol LoginViewModelOutput {
    var isLoginBtnEnable: Observable<Bool> { get }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInput { get }
    var outputs: LoginViewModelOutput { get }
}

struct LoginViewModel: LoginViewModelType, LoginViewModelInput, LoginViewModelOutput {
    var inputs: LoginViewModelInput { return self }
    var outputs: LoginViewModelOutput { return self }
    var emailText: Observable<String>
    var passText: Observable<String>
    var isLoginBtnEnable: Observable<Bool>
    
    init(emailField: Observable<String>, passField: Observable<String>) {
        emailText = emailField
        passText = passField
        
        let isEmpty = Observable.combineLatest(emailText, passText) { email, pass -> LoginValidationResult in
            LoginValidation.validateEmpty(email: email, pass: pass)
        }
        .share(replay: 1)
        
        isLoginBtnEnable = Observable.combineLatest([isEmpty], { empty in
            empty[0].isValid
        })
        .share(replay: 1)
    }
}
