import Foundation
import RxSwift

protocol MypageEditViewModelInput {
    var belongText: Observable<String> { get }
    var positionText: Observable<String> { get }
    var mailText: Observable<String> { get }
}

protocol MypageEditViewModelOutput {
    var isSaveBtnEnable: Observable<Bool> { get }
    var positionArr: Array<String> { get }
    var isOverBelong: Observable<Bool> { get }
}

protocol MypageEditViewModelType {
    var inputs: MypageEditViewModelInput { get }
    var outputs: MypageEditViewModelOutput { get }
}

class MypageEditViewModel: MypageEditViewModelType, MypageEditViewModelInput, MypageEditViewModelOutput {
    var inputs: MypageEditViewModelInput { return self }
    var outputs: MypageEditViewModelOutput { return self }
    var isSaveBtnEnable: Observable<Bool>
    var belongText: Observable<String>
    var positionText: Observable<String>
    var mailText: Observable<String>
    var positionArr: Array<String>
    var isOverBelong: Observable<Bool>
    let disposeBag = DisposeBag()
    
    init(belongField: Observable<String>, positionField: Observable<String>, mailField: Observable<String>) {
        positionArr = [
            R.string.locarizable.empty(), R.string.locarizable.player(), R.string.locarizable.manager(),
            R.string.locarizable.boss(), R.string.locarizable.department(), R.string.locarizable.staff()
        ]
        belongText = belongField
        positionText = positionField
        mailText = mailField
        
        isOverBelong = belongText
            .map({ text -> Bool in
                return MypageEditValidation.validateIsOverBelong(name: text)
            }).asObservable()
        
        let isEmpty = Observable.combineLatest(belongText, positionText, mailText) { (belong, position, mail) -> MypageEditValidationResult in
            MypageEditValidation.validationEmpty(belong: belong, position: position, email: mail)
        }.share(replay: 1)
        
        let emailFieldWhetherMatch = Observable.combineLatest([mailText], { mail -> MemberInfoRegisterValidationResult in
            return MypageEditValidation.validateEmail(email: mail[0])
        }).share(replay: 1)
        
        isSaveBtnEnable = Observable.combineLatest(isEmpty, emailFieldWhetherMatch) { empty, email in
            empty.isValid &&
                email.isValid
        }.share(replay: 1)
    }
    
    func updateMypage(uid: String, team: String, role: String, mail: String, completion: @escaping (String?, Error?) -> Void) {
        let updateData = ["team": team, "role": role, "mail": mail]
        let updateTeam = ["belong": team]
        MypageRepositoryImpl().updateMypageData(uid: uid, updateData: updateData, updateTeam: updateTeam)
            .subscribe { single in
                switch single {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
}
