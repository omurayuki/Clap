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
    
    init(teamIdField: Observable<String>, gradeField: Observable<String>, sportsKindField: Observable<String>) {
        teamIdText = teamIdField
        representGrade = gradeField
        representSportsKind = sportsKindField
        
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
