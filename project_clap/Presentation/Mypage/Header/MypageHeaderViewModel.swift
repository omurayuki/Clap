import Foundation
import RxSwift
import RxCocoa

protocol MypageHeaderViewModelImput {}

protocol MypageHeaderViewModelOutput {}

protocol MypageHeaderViewModelType {
    var inputs: MypageHeaderViewModelImput { get }
    var outputs: MypageHeaderViewModelOutput { get }
}

class MypageHeaderViewModel: MypageHeaderViewModelType, MypageHeaderViewModelImput, MypageHeaderViewModelOutput {
    var inputs: MypageHeaderViewModelImput { return self }
    var outputs: MypageHeaderViewModelOutput { return self }
    private let repository: MypageRepository = MypageRepositoryImpl()
    let disposeBag = DisposeBag()
    
    func fetchDraftDiaries(submit: Bool, uid: String, completion: @escaping ([TimelineCellData]?, Error?) -> Void) {
        repository.fetchDiaryData(submit: submit, uid: uid)
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
        repository.fetchDiaryData(submit: submit, uid: uid)
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
