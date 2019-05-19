import Foundation
import Realm
import RealmSwift
import RxSwift
import Firebase
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
    var positionArr: BehaviorRelay<[String]> { get }
    var yearArr: BehaviorRelay<[String]> { get }
    var isOverName: Observable<Bool> { get }
    var isOverPass: Observable<Bool> { get }
    var isOverRepass: Observable<Bool> { get }
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
    var positionArr: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [""])
    var yearArr: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [""])
    var isOverName: Observable<Bool>
    var isOverPass: Observable<Bool>
    var isOverRepass: Observable<Bool>
    let localRepository: LoSignupRepository = LoSignupRepositoryImpl()
    let disposeBag = DisposeBag()
    
    init(nameField: Observable<String>, mailField: Observable<String>,
         passField: Observable<String>, rePassField: Observable<String>,
         positionField: Observable<String>, yearField: Observable<String>, registBtn: Observable<()>) {
        nameText = nameField
        mailText = mailField
        passText = passField
        rePassText = rePassField
        memberPosition = positionField
        memberYear = yearField
        registBtnTap = registBtn
        positionArr.accept([
            R.string.locarizable.empty(), R.string.locarizable.player(),
            R.string.locarizable.leader(), R.string.locarizable.manager()
            ])
        yearArr.accept([
            R.string.locarizable.empty(), R.string.locarizable.first_year_student(),
            R.string.locarizable.second_year_student(), R.string.locarizable.third_year_student(),
            R.string.locarizable.fourth_year_student()
            ])
        
        isOverName = nameText
            .map{ text -> Bool in
                return RepresentMemberRegisterValidation.validateIsOverName(name: text)
            }.asObservable()
        
        isOverPass = passText
            .map { text -> Bool in
                return RepresentMemberRegisterValidation.validateIsOverPass(pass: text)
            }.asObservable()
        
        isOverRepass = rePassText
            .map{ text -> Bool in
                return RepresentMemberRegisterValidation.validateIsOverPass(pass: text)
            }.asObservable()
        
        let isEmptyField = Observable
            .combineLatest(nameText,
                           mailText,
                           passText,
                           rePassText) { name, mail, pass, rePass -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validateEmpty(name: name, mail: mail, pass: pass, rePass: rePass)
        }
        .share(replay: 1)
        
        let passFieldWhetherMatch = Observable
            .combineLatest(passText, rePassText) { pass, repass -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validatePass(pass: pass, rePass: repass)
        }
        .share(replay: 1)
        
        let emailFieldWhetherMatch = Observable
            .combineLatest([mailText], { mail -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validateEmail(email: mail[0])
        })
        .share(replay: 1)
        
        let isEmptyPicker = Observable
            .combineLatest(memberPosition, memberYear) { position, year -> RepresentMemberRegisterValidationResult in
            return RepresentMemberRegisterValidation.validatePicker(position: position, year: year)
        }
        
        isRegistBtnEnable = Observable
            .combineLatest(isEmptyField,
                           passFieldWhetherMatch,
                           emailFieldWhetherMatch,
                           isEmptyPicker) { (empty, pass, mail, picker) in
            empty.isValid &&
            pass.isValid &&
            mail.isValid &&
            picker.isValid
        }
        .share(replay: 1)
    }
    
    func saveToSingleton(name: String,
                         mail: String,
                         representMemberPosition: String,
                         representMemberYear: String) {
        localRepository.saveToTeamSingleton(name: name,
                                        mail: mail,
                                        representMemberPosition: representMemberPosition,
                                        representMemberYear: representMemberYear)
    }
    
    func saveToSingleton(uid: String, completion: @escaping () -> Void) {
        UserSingleton.sharedInstance.uid = uid
        completion()
    }
    
    func getUserData() -> Results<User>? {
        return localRepository.getUserData()
    }

    func signup(email: String, pass: String, completion: @escaping (String) -> Void) {
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
    
    func saveTeamData(teamId: String, team: String, grade: String, sportsKind: String) {
        SignupRepositoryImpl().saveTeamData(teamId: teamId,
                                          team: team,
                                          grade: grade,
                                          sportsKind: sportsKind)
            .subscribe { string in
                switch string {
                case .success(_):
                    return
                case .error(_):
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    func registUserWithTeam(teamId: String, uid: String) {
        SignupRepositoryImpl().registUserWithTeam(teamId: teamId, uid: uid)
            .subscribe { string in
                switch string {
                case .success(_):
                    return
                case .error(_):
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    func saveUserData(uid: String, teamId: String,
                      name: String, role: String,
                      mail: String, team: String,
                      completion: @escaping (String?, Error?) -> Void) {
        SignupRepositoryImpl().saveUserData(user: uid, teamId: teamId,
                                          name: name, role: role,
                                          mail: mail, team: team)
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
}
