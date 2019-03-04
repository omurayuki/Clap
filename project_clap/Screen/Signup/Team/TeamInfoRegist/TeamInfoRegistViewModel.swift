import Foundation
import RxSwift
import RxCocoa

protocol TeamInfoRegistViewModelInput {
    var teamIdText: Observable<String> { get }
}

protocol TeamInfoRegistViewModelOutput {
    var isNextBtnEnable: Observable<ValidationResult> { get }
}

protocol TeamInfoRegistViewModelType {
    var inputs: TeamInfoRegistViewModelInput { get }
    var outputs: TeamInfoRegistViewModelOutput { get }
}

struct TeamInfoRegistViewModel: TeamInfoRegistViewModelType, TeamInfoRegistViewModelInput, TeamInfoRegistViewModelOutput {
    var inputs: TeamInfoRegistViewModelInput { return self }
    var outputs: TeamInfoRegistViewModelOutput { return self }
    var teamIdText: Observable<String>
    var isNextBtnEnable: Observable<ValidationResult>
    
    init(teamIdText: Observable<String>) {
        self.teamIdText = teamIdText
        
        isNextBtnEnable = teamIdText.asObservable()
            .map({ text -> ValidationResult in
                return TeamInfoRegistValidation.validate(teamId: text)
            })
            .share(replay: 1)
    }
}


//文字を受け取って10文字以上ならtextfieldの枠を緑に、その中で全角があれば赤く

//func gethhhh() -> [String] {
//    //配列をかくviewController側の
//}
