import Foundation
import RxSwift

protocol ConfirmationTeamIdViewModelInput {
    
}

protocol ConfirmationTeamIdViewModelOutput {
    
}

protocol ConfirmationTeamIdViewModelType {
    var inputs: ConfirmationTeamIdViewModelInput { get }
    var outputs: ConfirmationTeamIdViewModelOutput { get }
}

final class ConfirmationTeamIdViewModel: ConfirmationTeamIdViewModelType, ConfirmationTeamIdViewModelInput, ConfirmationTeamIdViewModelOutput {
    var inputs: ConfirmationTeamIdViewModelInput { return self }
    var outputs: ConfirmationTeamIdViewModelOutput { return self }
    let disposeBag = DisposeBag()
    
    func fetchBelongData(teamId: String, completion: @escaping (String?) -> Void) {
        SignupRepositoryImpl().fetchBelongData(teamId: teamId, completion: completion)
    }
}
