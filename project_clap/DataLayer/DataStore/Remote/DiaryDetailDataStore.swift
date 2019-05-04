import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth


protocol DiaryDetailDataStore {
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]>
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, diaryId: String,
                     submitted: Bool) -> Single<String>
}

struct DiaryDetailDataStoreImpl: DiaryDetailDataStore {
    
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("diary")
                .document(teamId)
                .collection("diaries")
                .document(diaryId)
                .getDocument { snapshot, error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    guard let data = snapshot?.data() else { return }
                    guard
                        let text1 = data["text_1"] as? String, let text2 = data["text_2"] as? String,
                        let text3 = data["text_3"] as? String, let text4 = data["text_4"] as? String,
                        let text5 = data["text_5"] as? String, let text6 = data["text_6"] as? String,
                        let date = data["date"] as? String
                        else { return }
                    single(.success([text1, text2, text3, text4, text5, text6, date]))
                    
                    DiarySingleton.sharedInstance.diaryId = diaryId; DiarySingleton.sharedInstance.date = date
                    DiarySingleton.sharedInstance.text1 = text1; DiarySingleton.sharedInstance.text2 = text2
                    DiarySingleton.sharedInstance.text3 = text3; DiarySingleton.sharedInstance.text4 = text4
                    DiarySingleton.sharedInstance.text5 = text5; DiarySingleton.sharedInstance.text6 = text6
                }
            return Disposables.create()
        })
    }
    
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, diaryId: String,
                     submitted: Bool) -> Single<String> {
        let setData = [
            "text_1": text1, "text_2": text2,
            "text_3": text3, "text_4": text4,
            "text_5": text5, "text_6": text6,
            "date": stringDate,
            "submit": submitted,
            "time": DateFormatter.acquireCurrentTime(),
            "name": UserSingleton.sharedInstance.name, //// if name changed, must update draft name
            "commented": false,
            "created_at": FieldValue.serverTimestamp()
            ] as [String : Any]
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db.collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .document(diaryId)
                .updateData(setData, completion: { error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    single(.success("successful"))
                })
            return Disposables.create()
        })
    }
}
