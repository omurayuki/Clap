import Foundation
import RxSwift
import RxCocoa

protocol TeamInfoRegistViewModelInput {
    var teamText: Driver<String> { get }
    var representGrade: Driver<String> { get }
    var representSportsKind: Driver<String> { get }
}

protocol TeamInfoRegistViewModelOutput {
    var isNextBtnEnable: Observable<Bool> { get }
    var gradeArr: BehaviorRelay<[String]> { get }
    var sportsKindArr: BehaviorRelay<[String]> { get }
    var isOverTeamField: Observable<Bool> { get }
}

protocol TeamInfoRegistViewModelType {
    var inputs: TeamInfoRegistViewModelInput { get }
    var outputs: TeamInfoRegistViewModelOutput { get }
}

struct TeamInfoRegistViewModel: TeamInfoRegistViewModelType, TeamInfoRegistViewModelInput, TeamInfoRegistViewModelOutput {
    var inputs: TeamInfoRegistViewModelInput { return self }
    var outputs: TeamInfoRegistViewModelOutput { return self }
    var teamText: Driver<String>
    var representGrade: Driver<String>
    var representSportsKind: Driver<String>
    var isNextBtnEnable: Observable<Bool>
    var gradeArr: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [""])
    var sportsKindArr: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [""])
    var isOverTeamField: Observable<Bool>
    let localRepository: LoSignupRepository = LoSignupRepositoryImpl()
    let disposeBag = DisposeBag()
    
    init(teamField: Driver<String>, gradeField: Driver<String>, sportsKindField: Driver<String>) {
        teamText = teamField
        representGrade = gradeField
        representSportsKind = sportsKindField
        gradeArr.accept([
            R.string.locarizable.empty(), R.string.locarizable.junior_high_school(),
            R.string.locarizable.high_school(), R.string.locarizable.university(),
            R.string.locarizable.social()
        ])
        sportsKindArr.accept([
            R.string.locarizable.empty(), R.string.locarizable.rugby(),
            R.string.locarizable.base_ball(), R.string.locarizable.soccer(),
            R.string.locarizable.basket_ball(), R.string.locarizable.kendo(),
            R.string.locarizable.judo()
        ])
        
        isOverTeamField = teamText
            .map { text -> Bool in
                return TeamInfoRegistValidation.validateIsOver(team: text)
            }.asObservable()
        
        let isEmptyPicker = Driver
            .combineLatest(representGrade, representSportsKind) { position, year -> TeamInfoRegistValidationResult in
                return TeamInfoRegistValidation.validatePicker(position: position, year: year)
            }.asDriver()
        
        let isCount = teamText
            .asDriver()
            .map({ text -> TeamInfoRegistValidationResult in
                return TeamInfoRegistValidation.validateIsUnder(team: text)
            }).asDriver()
        
        isNextBtnEnable = Driver
            .combineLatest(isEmptyPicker, isCount) { (picker, count) in
                picker.isValid &&
                    count.isValid
            }.asObservable()
    }
    
    func saveToSingleton(team: String, grade: String, sportsKind: String) {
        localRepository.saveToTeamSingleton(team: team, grade: grade, sportsKind: sportsKind)
    }
}
