import Foundation
import RxSwift
import RxCocoa

protocol TabBarViewModelInput {}

protocol TabBarViewModelOutput {}

protocol TabBarViewModelType {
    var inputs: TabBarViewModelInput { get }
    var outputs: TabBarViewModelOutput { get }
}

class TabBarViewModel: TabBarViewModelType, TabBarViewModelInput, TabBarViewModelOutput {
    var inputs: TabBarViewModelInput { return self }
    var outputs: TabBarViewModelOutput { return self }
    let disposeBag = DisposeBag()
    
    func fetchUserData(uid: String, completion: @escaping ([String]?, Error?) -> Void) {
        TabBarRepositoryImpl().fetchUserData(uid: uid)
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
