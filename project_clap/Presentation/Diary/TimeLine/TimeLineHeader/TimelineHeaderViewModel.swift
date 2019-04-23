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
    let disposeBag = DisposeBag()
    
    func fetchDiaries(completion: @escaping ([TimelineCellData]?, Error?) -> Void) {
        TimelineRepositoryImpl().fetchDiaries()
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
    
    func fetchDraftDiaries() {
        
    }
    
    func fetchSubmittedDiaries() {
        
    }
}
