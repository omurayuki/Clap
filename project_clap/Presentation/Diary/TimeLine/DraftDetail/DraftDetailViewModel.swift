import Foundation
import RxSwift
import RxCocoa

protocol DraftDetailViewModelInput {
    var text1: Driver<String> { get }
    var text2: Driver<String> { get }
    var text3: Driver<String> { get }
    var text4: Driver<String> { get }
    var text5: Driver<String> { get }
    var text6: Driver<String> { get }
}

protocol DraftDetailViewModelOutput {
    var isBtnEnable: Driver<Bool> { get }
    var isCountEnable: Driver<[Bool]> { get }
}

protocol DraftDetailViewModelType {
    var inputs: DraftDetailViewModelInput { get }
    var outputs: DraftDetailViewModelOutput { get }
}

class DraftDetailViewModel: DraftDetailViewModelType, DraftDetailViewModelInput, DraftDetailViewModelOutput {
    var inputs: DraftDetailViewModelInput { return self }
    var outputs: DraftDetailViewModelOutput { return self }
    var text1: Driver<String>
    var text2: Driver<String>
    var text3: Driver<String>
    var text4: Driver<String>
    var text5: Driver<String>
    var text6: Driver<String>
    var isBtnEnable: Driver<Bool>
    var isCountEnable: Driver<[Bool]>
    let disposeBag = DisposeBag()
    
    init(text1: Driver<String>, text2: Driver<String>,
         text3: Driver<String>, text4: Driver<String>,
         text5: Driver<String>, text6: Driver<String>) {
        self.text1 = text1
        self.text2 = text2
        self.text3 = text3
        self.text4 = text4
        self.text5 = text5
        self.text6 = text6
        
        let isMoreThan = Driver
            .combineLatest(self.text1, self.text2,
                           self.text3, self.text4,
                           self.text5, self.text6) { text1, text2,
                            text3, text4,
                            text5, text6 -> DraftDiaryValidationResult in
                            DraftDiaryValidation.validateText(text1: text1, text2: text2,
                                                                text3: text3, text4: text4,
                                                                text5: text5, text6: text6)
            }.asDriver()
        
        isBtnEnable = Driver
            .combineLatest([isMoreThan]) { count in
                count[0].isValid
            }.asDriver()
        
        isCountEnable = Driver
            .combineLatest(self.text1, self.text2,
                           self.text3, self.text4,
                           self.text5, self.text6) { text1, text2,
                            text3, text4,
                            text5, text6 in
                            return [
                                text1.count > 15, text2.count > 200,
                                text3.count > 200, text4.count > 200,
                                text5.count > 200, text6.count > 200
                            ]
            }.asDriver()
    }
    
    func fetchDiaryDetail(teamId: String, diaryId: String, completion: @escaping ([String]?, Error?) -> Void) {
        DiaryDetailDataStoreImpl().fetchDiaryDetail(teamId: teamId, diaryId: diaryId)
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
    
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, diaryId: String,
                     submitted: Bool, completion: @escaping (String?, Error?) -> Void) {
        DiaryDetailDataStoreImpl().registDiary(text1: text1, text2: text2,
                                               text3: text3, text4: text4,
                                               text5: text5, text6: text6,
                                               stringDate: stringDate, diaryId: diaryId,
                                               submitted: submitted)
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
