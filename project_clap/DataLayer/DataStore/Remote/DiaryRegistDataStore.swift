import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol DiaryRegistDataStore {
    func registDiary(text1: String, text2: String, text3: String, text4: String, text5: String, text6: String, stringDate: String, submitted: Bool) -> Single<String>
}

class DiaryRegistDataStoreImpl: DiaryRegistDataStore {
    func registDiary(text1: String, text2: String,
                     text3: String, text4: String,
                     text5: String, text6: String,
                     stringDate: String, submitted: Bool) -> Single<String> {
        let diaryId = RandomString.generateRandomString(length: 25)
        let setData = [
            "text_1": text1, "text_2": text2,
            "text_3": text3, "text_4": text4,
            "text_5": text5, "text_6": text6,
            "date": stringDate,
            "submit": submitted,
            "time": DateFormatter.acquireCurrentTime(),
            "userId": UserSingleton.sharedInstance.uid,
            "name": UserSingleton.sharedInstance.name,
            "diaryId": diaryId,
            "commented": false
        ] as [String : Any]
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db.collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .document(diaryId)
                .setData(setData, completion: { error in
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
