import Foundation
import RxSwift
import RxCocoa

protocol SubmittedDetailViewModelInput {}

protocol SubmittedDetailViewModelOutput {}

protocol SubmittedDetailViewModelType {
    var inputs: SubmittedDetailViewModelInput { get }
    var outputs: SubmittedDetailViewModelOutput { get }
}

class SubmittedDetailViewModel: SubmittedDetailViewModelType, SubmittedDetailViewModelInput, SubmittedDetailViewModelOutput {
    var inputs: SubmittedDetailViewModelInput { return self }
    var outputs: SubmittedDetailViewModelOutput { return self }
    let disposeBag = DisposeBag()
    
    func fetchDiaryDetail(teamId: String, diaryId: String, completion: @escaping ([String]?, Error?) -> Void) {
        SubmittedDetailRepositoryImpl().fetchDiaryDetail(teamId: teamId, diaryId: diaryId)
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
