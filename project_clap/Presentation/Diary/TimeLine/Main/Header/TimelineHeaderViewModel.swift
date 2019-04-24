import Foundation
import RxSwift
import RxCocoa

protocol TimelineHeaderViewModelInput {}

protocol TimelineHeaderViewModelOutput {}

protocol TimelineHeaderViewModelType {
    var inputs: TimelineHeaderViewModelInput { get }
    var outputs: TimelineHeaderViewModelOutput { get }
}

class TimelineHeaderViewModel: TimelineHeaderViewModelType, TimelineHeaderViewModelInput, TimelineHeaderViewModelOutput {
    var inputs: TimelineHeaderViewModelInput { return self }
    var outputs: TimelineHeaderViewModelOutput { return self }
    private let repository: TimelineRepository = TimelineRepositoryImpl()
    let disposeBag = DisposeBag()
    
    func fetchDiaries(completion: @escaping ([TimelineCellData]?, Error?) -> Void) {
        repository.fetchDiaries()
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
    
    func fetchDraftDiaries(submit: Bool, uid: String, completion: @escaping ([TimelineCellData]?, Error?) -> Void) {
        repository.fetchIndividualDiaries(submit: submit, uid: uid)
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
    
    func fetchSubmittedDiaries(submit: Bool, uid: String, completion: @escaping ([TimelineCellData]?, Error?) -> Void) {
        repository.fetchIndividualDiaries(submit: submit, uid: uid)
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
