import Foundation
import RxSwift
import RxCocoa

protocol SubmittedDetailDataStore {
    func fetchDiaryDetail(teamId: String, diaryId: String) -> Single<[String]>
}

struct SubmittedDetailDataStoreImpl: SubmittedDetailDataStore {
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
                        let text5 = data["text_5"] as? String, let text6 = data["text_6"] as? String
                        else { return }
                    single(.success([text1, text2, text3, text4, text5, text6]))
                    
                    DiarySingleton.sharedInstance.diaryId = diaryId
                    DiarySingleton.sharedInstance.text1 = text1; DiarySingleton.sharedInstance.text2 = text2
                    DiarySingleton.sharedInstance.text3 = text3; DiarySingleton.sharedInstance.text4 = text4
                    DiarySingleton.sharedInstance.text5 = text5; DiarySingleton.sharedInstance.text6 = text6
            }
            return Disposables.create()
        })
    }
}
