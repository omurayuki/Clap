import Foundation
import RxSwift
import RxCocoa

protocol TimelineViewModelInput {
    
}

protocol TimelineViewModelOutput {
    
}

protocol TimelineViewModelType {
    var inputs: TimelineViewModelInput { get }
    var outputs: TimelineViewModelOutput { get }
}

class TimelineViewModel: TimelineViewModelType, TimelineViewModelInput, TimelineViewModelOutput {
    var inputs: TimelineViewModelInput { return self }
    var outputs: TimelineViewModelOutput { return self }
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
}
