import Foundation
import RxSwift
import RxCocoa

protocol TeamInfoRegistViewModelInput {
    var teamIdText: Driver<String> { get }
    var representGrade: Driver<String> { get }
    var representSportsKind: Driver<String> { get }
}

protocol TeamInfoRegistViewModelOutput {
    var isNextBtnEnable: Observable<Bool> { get }
    var gradeArr: Array<String> { get }
    var sportsKindArr: Array<String> { get }
}

protocol TeamInfoRegistViewModelType {
    var inputs: TeamInfoRegistViewModelInput { get }
    var outputs: TeamInfoRegistViewModelOutput { get }
}

struct TeamInfoRegistViewModel: TeamInfoRegistViewModelType, TeamInfoRegistViewModelInput, TeamInfoRegistViewModelOutput {
    var inputs: TeamInfoRegistViewModelInput { return self }
    var outputs: TeamInfoRegistViewModelOutput { return self }
    var teamIdText: Driver<String>
    var representGrade: Driver<String>
    var representSportsKind: Driver<String>
    var isNextBtnEnable: Observable<Bool>
    var gradeArr: Array<String>
    var sportsKindArr: Array<String>
    let disposeBag = DisposeBag()
    
    init(teamIdField: Driver<String>, gradeField: Driver<String>, sportsKindField: Driver<String>) {
        teamIdText = teamIdField
        representGrade = gradeField
        representSportsKind = sportsKindField
        gradeArr = [
            R.string.locarizable.empty(), R.string.locarizable.junior_high_school(),
            R.string.locarizable.high_school(), R.string.locarizable.university(), R.string.locarizable.social()
        ]
        sportsKindArr = [
            R.string.locarizable.empty(), R.string.locarizable.rugby(),
            R.string.locarizable.base_ball(), R.string.locarizable.soccer(),
            R.string.locarizable.basket_ball(), R.string.locarizable.kendo(), R.string.locarizable.judo()
        ]
        
        let isEmptyPicker = Driver.combineLatest(representGrade, representSportsKind) { position, year -> TeamInfoRegistValidationResult in
                return TeamInfoRegistValidation.validatePicker(position: position, year: year)
            }.asDriver()
        
        let isCount = teamIdText.asDriver()
            .map({ text -> TeamInfoRegistValidationResult in
                return TeamInfoRegistValidation.validate(team: text)
            }).asDriver()
        
        isNextBtnEnable = Driver.combineLatest(isEmptyPicker, isCount) { (picker, count) in
                picker.isValid &&
                count.isValid
            }.asObservable()
    }
}
