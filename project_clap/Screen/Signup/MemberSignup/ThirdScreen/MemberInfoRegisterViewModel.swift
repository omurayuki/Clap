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
    
    init(nameField: Observable<String>, mailField: Observable<String>, passField: Observable<String>, rePassField: Observable<String>, positionField: Observable<String>, registBtn: Observable<()>) {
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
        
        let isEmptyField = Observable.combineLatest(nameText, mailText, passText, rePassText) { name, mail, pass, rePass -> MemberInfoRegisterValidationResult in
            return MemberInfoRegisterValidation.validateEmpty(name: name, mail: mail, pass: pass, rePass: rePass)
        }
        .share(replay: 1)
        
        let passFieldWhetherMatch = Observable.combineLatest(passText, rePassText) { pass, repass -> MemberInfoRegisterValidationResult in
            return MemberInfoRegisterValidation.validatePass(pass: pass, rePass: repass)
        }
        .share(replay: 1)
        
        let emailFieldWhetherMatch = Observable.combineLatest([mailText], { mail -> MemberInfoRegisterValidationResult in
            return MemberInfoRegisterValidation.validateEmail(email: mail[0])
        })
        .share(replay: 1)
        
        let isEmptyPicker = Observable.combineLatest([memberPosition]) { position -> MemberInfoRegisterValidationResult in
            return MemberInfoRegisterValidation.validatePicker(position: position[0])
        }
        
        isRegistBtnEnable = Observable.combineLatest(isEmptyField, passFieldWhetherMatch, emailFieldWhetherMatch, isEmptyPicker) { (empty, pass, mail, picker) in
            empty.isValid &&
                pass.isValid &&
                mail.isValid &&
                picker.isValid
            }
            .share(replay: 1)
    }
}
