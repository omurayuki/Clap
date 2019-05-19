import Foundation
import RxSwift
import RxCocoa

protocol DiaryDetailRepository {
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]>
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, diaryId: String,
                     submitted: Bool) -> Single<String>
}

struct DiaryDetailRepositoryImpl: DiaryDetailRepository {
    
    private let dataStore: DiaryDetailDataStore = DiaryDetailDataStoreImpl()
    
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]> {
        return dataStore.fetchDiaryDetail(teamId: teamId, diaryId: diaryId)
    }
    
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, diaryId: String,
                     submitted: Bool) -> Single<String> {
        return dataStore.registDiary(text1: text1, text2: text2,
                                     text3: text3, text4: text4,
                                     text5: text5, text6: text6,
                                     stringDate: stringDate, diaryId: diaryId,
                                     submitted:submitted)
    }
}
