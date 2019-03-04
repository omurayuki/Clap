import Foundation
import RxSwift
import RxCocoa

protocol RepresentMemberRegisterViewModelInput {
    var nameText: Observable<String> { get }
    var mailText: Observable<String> { get }
    var passText: Observable<String> { get }
    var rePassText: Observable<String> { get }
    var registBtnTap: Observable<()> { get }
}

protocol RepresentMemberRegisterViewModelOutput {
    var isRegistBtnEnable: Observable<Bool> { get }
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
    var isRegistBtnEnable: Observable<Bool>
    
    init(nameField: Observable<String>, mailField: Observable<String>, passField: Observable<String>, rePassField: Observable<String>, registBtn: Observable<()>) {
        nameText = nameField
        mailText = mailField
        passText = passField
        rePassText = rePassField
        registBtnTap = registBtn
        
        let isEmptyField = Observable.combineLatest(nameText, mailText, passText, rePassText) { name, mail, pass, rePass -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidate.validateEmpty(name: name, mail: mail, pass: pass, rePass: rePass)
        }
        .share(replay: 1)
        
        let passFieldWhetherMatch = Observable.combineLatest(passText, rePassText) { pass, repass -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidate.validatePass(pass: pass, rePass: repass)
        }
        .share(replay: 1)
        
        let emailFieldWhetherMatch = Observable.combineLatest([mailText], { mail -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidate.validateEmail(email: mail[0])
        })
        .share(replay: 1)
        
        isRegistBtnEnable = Observable.combineLatest(isEmptyField, passFieldWhetherMatch, emailFieldWhetherMatch) { (empty, pass, mail) in
            empty.isValid &&
            pass.isValid &&
            mail.isValid
        }
        .share(replay: 1)
    }
}
