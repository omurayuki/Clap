import Foundation
import RxSwift
import RealmSwift

protocol DiaryRegistRepository {
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, submitted: Bool) -> Single<String>
}

struct DiaryRegistRepositoryImpl: DiaryRegistRepository {
    
    private let dataSrore: DiaryRegistDataStore = DiaryRegistDataStoreImpl()
    
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, submitted: Bool) -> Single<String> {
        return dataSrore.registDiary(text1: text1, text2: text2,
                                     text3: text3, text4: text4,
                                     text5: text5, text6: text6,
                                     stringDate: stringDate, submitted: submitted)
    }
}
