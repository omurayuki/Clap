import Foundation
import RxSwift
import RxCocoa

protocol MemberInfoRegisterViewModelInput {
    var nameText: Observable<String> { get }
    var mailText: Observable<String> { get }
    var passText: Observable<String> { get }
    var rePassText: Observable<String> { get }
    var memberPosition: Observable<String> { get }
    var registBtnTap: Observable<()> { get }
}

protocol MemberInfoRegisterViewModelOutput {
    var isRegistBtnEnable: Observable<Bool> { get }
    var positionArr: Array<String> { get }
    var isOverName: Observable<Bool> { get }
    var isOverPass: Observable<Bool> { get }
    var isOverRepass: Observable<Bool> { get }
}

protocol MemberInfoRegisterViewModelType {
    var inputs: MemberInfoRegisterViewModelInput { get }
    var outputs: MemberInfoRegisterViewModelOutput { get }
}

struct MemberInfoRegisterViewModel: MemberInfoRegisterViewModelType, MemberInfoRegisterViewModelInput, MemberInfoRegisterViewModelOutput {
    var inputs: MemberInfoRegisterViewModelInput { return self }
    var outputs: MemberInfoRegisterViewModelOutput { return self }
    var nameText: Observable<String>
    var mailText: Observable<String>
    var passText: Observable<String>
    var rePassText: Observable<String>
    var registBtnTap: Observable<()>
    var memberPosition: Observable<String>
    var isRegistBtnEnable: Observable<Bool>
    var positionArr: Array<String>
    var isOverName: Observable<Bool>
    var isOverPass: Observable<Bool>
    var isOverRepass: Observable<Bool>
    let disposeBag = DisposeBag()
    
    init(nameField: Observable<String>, mailField: Observable<String>,
         passField: Observable<String>, rePassField: Observable<String>,
         positionField: Observable<String>, registBtn: Observable<()>) {
        nameText = nameField
        mailText = mailField
        passText = passField
        rePassText = rePassField
        memberPosition = positionField
        registBtnTap = registBtn
        positionArr = [
            R.string.locarizable.empty(), R.string.locarizable.player(), R.string.locarizable.manager(),
            R.string.locarizable.boss(), R.string.locarizable.department(), R.string.locarizable.staff()
        ]
        
        isOverName = nameText
            .map{ text -> Bool in
                return MemberInfoRegisterValidation.validateIsOverName(name: text)
            }.asObservable()
        
        isOverPass = passText
            .map { text -> Bool in
                return MemberInfoRegisterValidation.validateIsOverPass(pass: text)
            }.asObservable()
        
        isOverRepass = rePassText
            .map{ text -> Bool in
                return MemberInfoRegisterValidation.validateIsOverPass(pass: text)
            }.asObservable()
        
        let isEmptyField = Observable
            .combineLatest(nameText, mailText, passText, rePassText) { name, mail, pass, rePass -> MemberInfoRegisterValidationResult in
                return MemberInfoRegisterValidation.validateEmpty(name: name, mail: mail, pass: pass, rePass: rePass)
            }
        
        let passFieldWhetherMatch = Observable
            .combineLatest(passText, rePassText) { pass, repass -> MemberInfoRegisterValidationResult in
                return MemberInfoRegisterValidation.validatePass(pass: pass, rePass: repass)
            }
        
        let emailFieldWhetherMatch = Observable
            .combineLatest([mailText]) { mail -> MemberInfoRegisterValidationResult in
                return MemberInfoRegisterValidation.validateEmail(email: mail[0])
            }
        
        let isEmptyPicker = Observable
            .combineLatest([memberPosition]) { position -> MemberInfoRegisterValidationResult in
                return MemberInfoRegisterValidation.validatePicker(position: position[0])
            }
        
        isRegistBtnEnable = Observable.combineLatest(isEmptyField, passFieldWhetherMatch, emailFieldWhetherMatch, isEmptyPicker) { (empty, pass, mail, picker) in
            empty.isValid &&
                pass.isValid &&
                mail.isValid &&
                picker.isValid
            }.share(replay: 1)
    }
    
    func saveToSingleton(name: String, mail: String, representMemberPosition: String) {
        TeamSignupSingleton.sharedInstance.name = name
        TeamSignupSingleton.sharedInstance.mail = mail
        TeamSignupSingleton.sharedInstance.representMemberPosition = representMemberPosition
    }
    
    func saveToSingleton(uid: String, completion: @escaping () -> Void) {
        UserSingleton.sharedInstance.uid = uid
        completion()
    }
    
    func signup(email: String, pass: String, completion: @escaping(String) -> Void) {
        SignupRepositoryImpl().signup(email: email, pass: pass, completion: { uid in
                completion(uid ?? "")
            })
            .subscribe { response in
                switch response {
                case .success(let data):
                    let user = User()
                    user.uid = data.user.uid
                    user.email = data.user.email ?? ""
                    user.saveUserData(user: user)
                case .error(_):
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    func saveUserData(uid: String, teamId: String, name: String, role: String, mail: String, team: String, completion: @escaping () -> Void) {
        SignupRepositoryImpl().saveUserData(user: uid, teamId: teamId,
                                            name: name, role: role,
                                            mail: mail, team: team, completion: {
            completion()
        })
    }
}
