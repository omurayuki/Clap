import Foundation
import RxSwift
import RxCocoa

protocol RemindPassViewModelInput {
    var emailText: Observable<String> { get }
}

protocol RemindPassViewModelOutput {
    var isSubmitBtnEnable: Observable<Bool> { get }
}

protocol RemindPassViewModelType {
    var inputs: RemindPassViewModelInput { get }
    var outputs: RemindPassViewModelOutput { get }
}

struct RemindPassViewModel: RemindPassViewModelType, RemindPassViewModelInput, RemindPassViewModelOutput {
    var inputs: RemindPassViewModelInput { return self }
    var outputs: RemindPassViewModelOutput { return self }
    var emailText: Observable<String>
    var isSubmitBtnEnable: Observable<Bool>
    let disposeBag = DisposeBag()
    
    init(emailField: Observable<String>) {
        emailText = emailField
        
        let isEmpty = Observable.combineLatest([emailText]) { email -> RemindPassValidationResult in
            return RemindPassValidation.validateEmpty(email: email[0])
        }.share(replay: 1)
        
        let isFormatedEmail = Observable.combineLatest([emailText]) { email -> RemindPassValidationResult in
            return RemindPassValidation.validateEmail(email: email[0])
        }.share(replay: 1)
        
        isSubmitBtnEnable = Observable.combineLatest(isEmpty, isFormatedEmail) { (empty, formatedEmail) -> Bool in
            empty.isValid &&
            formatedEmail.isValid
        }.share(replay: 1)
    }
    
    func resettingPassword(email: String, completion: @escaping (String?, Error?) -> Void) {
        RemindPassRepositoryImpl().resettingPassword(mail: email)
            .subscribe{ single in
                switch single {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
}
