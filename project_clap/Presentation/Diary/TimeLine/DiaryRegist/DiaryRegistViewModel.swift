import Foundation
import RxSwift
import UIKit
import RxCocoa

protocol DiaryRegistViewModelInput {
    var text1: Driver<String> { get }
    var text2: Driver<String> { get }
    var text3: Driver<String> { get }
    var text4: Driver<String> { get }
    var text5: Driver<String> { get }
    var text6: Driver<String> { get }
}

protocol DiaryRegistViewModelOutput {
    var isBtnEnable: Driver<Bool> { get }
    var isCountEnable: Driver<[Bool]> { get }
}

protocol DiaryRegistViewModelType {
    var inputs: DiaryRegistViewModelInput { get }
    var outputs: DiaryRegistViewModelOutput { get }
}

struct DiaryRegistViewModel: DiaryRegistViewModelType, DiaryRegistViewModelInput, DiaryRegistViewModelOutput {
    var inputs: DiaryRegistViewModelInput { return self }
    var outputs: DiaryRegistViewModelOutput { return self }
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
                                                     text5, text6 -> DiaryRegistavalidationResult in
                            DiaryRegistavalidation.validateText(text1: text1, text2: text2,
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
    
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, submitted: Bool,
                     completion: @escaping (String?, Error?) -> Void) {
        DiaryRegistRepositoryImpl().registDiary(text1: text1, text2: text2,
                                                text3: text3, text4: text4,
                                                text5: text5, text6: text6,
                                                stringDate: stringDate, submitted: submitted)
            .subscribe { single in
                switch single {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
    
    func emptyField<T: UITextView>(text1: T, text2: T, text3: T, text4: T, text5: T, text6: T) {
        let fields = [text1, text2, text3, text4, text5, text6]
        fields.forEach { field in
            field.text = ""
        }
    }
}
