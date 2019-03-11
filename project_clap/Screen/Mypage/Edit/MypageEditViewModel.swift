import Foundation
import RxSwift

protocol MypageEditViewModelInput {
    var belongText: Observable<String> { get }
    var positionText: Observable<String> { get }
    var mailText: Observable<String> { get }
}

protocol MypageEditViewModelOutput {
    var isSaveBtnEnable: Observable<Bool> { get }
}

protocol MypageEditViewModelType {
    var inputs: MypageEditViewModelInput { get }
    var outputs: MypageEditViewModelOutput { get }
}

struct MypageEditViewModel: MypageEditViewModelType, MypageEditViewModelInput, MypageEditViewModelOutput {
    var inputs: MypageEditViewModelInput { return self }
    var outputs: MypageEditViewModelOutput { return self }
    var isSaveBtnEnable: Observable<Bool>
    var belongText: Observable<String>
    var positionText: Observable<String>
    var mailText: Observable<String>
    
    init(belongField: Observable<String>, positionField: Observable<String>, mailField: Observable<String>) {
        belongText = belongField
        positionText = positionField
        mailText = mailField
        
        let isEmpty = Observable.combineLatest(belongText, positionText, mailText) { (belong, position, mail) -> MypageEditValidationResult in
            MypageEditValidation.validationEmpty(belong: belong, position: position, email: mail)
        }
        
        let isMore = Observable.combineLatest(belongText, positionText, mailText) { (belong, position, mail) -> MypageEditValidationResult in
            MypageEditValidation.validationIsMore(belong: belong, position: position, email: mail)
        }
        
        isSaveBtnEnable = Observable.combineLatest(isEmpty, isMore) { empty, more in
            return empty.isValid && more.isValid
        }
    }
}
