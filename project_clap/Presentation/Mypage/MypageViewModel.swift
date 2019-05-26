import Foundation
import RxSwift

protocol MypageViewModelInput {}

protocol MypageViewModelOutput {}

protocol MypageViewModeType {
    var inputs: MypageViewModelInput { get }
    var outputs: MypageViewModelOutput { get }
}

class MypageViewModel: MypageViewModeType, MypageViewModelInput, MypageViewModelOutput {
    var inputs: MypageViewModelInput { return self }
    var outputs: MypageViewModelOutput { return self }
    var disposeBag = DisposeBag()
    
    func fetchMypageData(uid: String, completion: @escaping (Mypage) -> Void) {
        MypageRepositoryImpl().fetchMypageData(uid: uid)
            .subscribe { single in
                switch single {
                case .success(let data):
                    completion(data)
                    return
                case .error(let error):
                    print(error.localizedDescription)
                    return
                }
            }.disposed(by: disposeBag)
    }
    
    func fetchDiaries(uid: String, completion: @escaping ([TimelineCellData]?, Error?) -> Void) {
        MypageRepositoryImpl().fetchDiaryData(submit: true, uid: uid)
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
