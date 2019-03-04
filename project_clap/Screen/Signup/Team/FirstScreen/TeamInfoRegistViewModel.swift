import Foundation
import RxSwift
import RxCocoa

protocol TeamInfoRegistViewModelInput {
    var teamIdText: Observable<String> { get }
    var representGrade: Observable<String> { get }
    var representSportsKind: Observable<String> { get }
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
    var teamIdText: Observable<String>
    var representGrade: Observable<String>
    var representSportsKind: Observable<String>
    var isNextBtnEnable: Observable<Bool>
    var gradeArr: Array<String>
    var sportsKindArr: Array<String>
    
    init(teamIdField: Observable<String>, gradeField: Observable<String>, sportsKindField: Observable<String>) {
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
        
        let isEmptyPicker = Observable
            .combineLatest(representGrade, representSportsKind) { position, year -> TeamInfoRegistValidationResult in
                return TeamInfoRegistValidation.validatePicker(position: position, year: year)
            }
            .share(replay: 1)
        
        
        let isCount = teamIdText.asObservable()
            .map({ text -> TeamInfoRegistValidationResult in
                return TeamInfoRegistValidation.validate(teamId: text)
            })
            .share(replay: 1)
        
        isNextBtnEnable = Observable.combineLatest(isEmptyPicker, isCount) { (picker, count) in
                picker.isValid &&
                count.isValid
            }
            .share(replay: 1)
    }
}
