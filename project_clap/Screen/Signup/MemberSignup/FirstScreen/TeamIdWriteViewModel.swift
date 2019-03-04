import Foundation
import RxSwift
import RxCocoa

protocol TeamIdWriteViewModelInput {
    var teamIdText: Observable<String> { get }
}

protocol TeamIdWriteViewModelOutput {
    var isConfirmBtnEnable: Observable<Bool> { get }
}

protocol TeamIdWriteViewModelType {
    var inputs: TeamIdWriteViewModelInput { get }
    var outputs: TeamIdWriteViewModelOutput { get }
}

struct TeamIdWriteViewModel: TeamIdWriteViewModelType, TeamIdWriteViewModelInput, TeamIdWriteViewModelOutput {
    var inputs: TeamIdWriteViewModelInput { return self }
    var outputs: TeamIdWriteViewModelOutput { return self }
    var teamIdText: Observable<String>
    var isConfirmBtnEnable: Observable<Bool>
    
    init(teamIdField: Observable<String>) {
        teamIdText = teamIdField
        
        let isEmpty = Observable.combineLatest([teamIdText]) { teamId -> TeamIdWriteValidationResult in
            return TeamIdWriteValidation.validateEmpty(teamId: teamId[0])
        }
        .share(replay: 1)
        
        let isMatch = Observable.combineLatest([teamIdText]) { teamId -> TeamIdWriteValidationResult in
            return TeamIdWriteValidation.validMatch(teamId: teamId[0])
        }
        .share(replay: 1)
        
        let isCount = Observable.combineLatest([teamIdText]) { teamId -> TeamIdWriteValidationResult in
            return TeamIdWriteValidation.validCharCount(teamId: teamId[0])
        }
        .share(replay: 1)
        
        isConfirmBtnEnable = Observable.combineLatest(isEmpty, isMatch, isCount) { (empty, match, count) in
            empty.isValid &&
            match.isValid &&
            count.isValid
        }
        .share(replay: 1)
    }
}
