import Foundation
import RxSwift
import RxCocoa

protocol RepresentMemberRegisterViewModelInput {
    var nameText: Observable<String> { get }
    var mailText: Observable<String> { get }
    var passText: Observable<String> { get }
    var rePassText: Observable<String> { get }
    var memberPosition: Observable<String> { get }
    var memberYear: Observable<String> { get }
    var registBtnTap: Observable<()> { get }
}

protocol RepresentMemberRegisterViewModelOutput {
    var isRegistBtnEnable: Observable<Bool> { get }
    var positionArr: Array<String> { get }
    var yearArr: Array<String> { get }
}

protocol RepresentMemberRegisterViewModelType {
    var inputs: RepresentMemberRegisterViewModelInput { get }
    var outputs: RepresentMemberRegisterViewModelOutput { get }
}

struct RepresentMemberRegisterViewModel: RepresentMemberRegisterViewModelType, RepresentMemberRegisterViewModelInput, RepresentMemberRegisterViewModelOutput {
    var inputs: RepresentMemberRegisterViewModelInput { return self }
    var outputs: RepresentMemberRegisterViewModelOutput { return self }
    var nameText: Observable<String>
    var mailText: Observable<String>
    var passText: Observable<String>
    var rePassText: Observable<String>
    var registBtnTap: Observable<()>
    var memberPosition: Observable<String>
    var memberYear: Observable<String>
    var isRegistBtnEnable: Observable<Bool>
    var positionArr: Array<String>
    var yearArr: Array<String>
    
    init(nameField: Observable<String>, mailField: Observable<String>, passField: Observable<String>, rePassField: Observable<String>, positionField: Observable<String>, yearField: Observable<String>, registBtn: Observable<()>) {
        nameText = nameField
        mailText = mailField
        passText = passField
        rePassText = rePassField
        memberPosition = positionField
        memberYear = yearField
        registBtnTap = registBtn
        positionArr = [
            R.string.locarizable.empty(), R.string.locarizable.player(), R.string.locarizable.leader(), R.string.locarizable.manager()
        ]
        yearArr = [
            R.string.locarizable.empty(), R.string.locarizable.first_year_student(),
            R.string.locarizable.second_year_student(), R.string.locarizable.third_year_student(), R.string.locarizable.fourth_year_student()
        ]
        
        let isEmptyField = Observable.combineLatest(nameText, mailText, passText, rePassText) { name, mail, pass, rePass -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validateEmpty(name: name, mail: mail, pass: pass, rePass: rePass)
        }
        .share(replay: 1)
        
        let passFieldWhetherMatch = Observable.combineLatest(passText, rePassText) { pass, repass -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validatePass(pass: pass, rePass: repass)
        }
        .share(replay: 1)
        
        let emailFieldWhetherMatch = Observable.combineLatest([mailText], { mail -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validateEmail(email: mail[0])
        })
        .share(replay: 1)
        
        let isEmptyPicker = Observable.combineLatest(memberPosition, memberYear) { position, year -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validatePicker(position: position, year: year)
        }
        
        isRegistBtnEnable = Observable.combineLatest(isEmptyField, passFieldWhetherMatch, emailFieldWhetherMatch, isEmptyPicker) { (empty, pass, mail, picker) in
            empty.isValid &&
            pass.isValid &&
            mail.isValid &&
            picker.isValid
        }
        .share(replay: 1)
    }
    
    func saveToSingleton(name: String, mail: String, representMemberPosition: String, representMemberYear: String) {
        TeamSignupSingleton.sharedInstance.name = name
        TeamSignupSingleton.sharedInstance.mail = mail
        TeamSignupSingleton.sharedInstance.representMemberPosition = representMemberPosition
        TeamSignupSingleton.sharedInstance.representMemberYear = representMemberYear
    }
    
    func saveToSingleton(uid: String, completion: @escaping () -> Void) {
        UIDSingleton.sharedInstance.uid = uid
        completion()
    }
}
