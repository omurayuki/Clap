import Foundation
import RxSwift
import RxCocoa
import Result

enum FirebaseError: Error {
    case networkError
    case fetchError(Error)
}

protocol CalendarDataStore {
    func registEvent(startToEnd: [String], startDate: String,
                     endDate: String, startTime: String,
                     endTime: String, title: String,
                     content: String) -> Single<Result<String, FirebaseError>>
}

struct CalendarDataStoreImpl: CalendarDataStore {
    
    func registEvent(startToEnd: [String], startDate: String,
                     endDate: String, startTime: String,
                     endTime: String, title: String,
                     content: String) -> Single<Result<String, FirebaseError>> {
        let eventCollectionPath = RandomString.generateRandomString(length: 20)
        let setData = [
            "userId": UserSingleton.sharedInstance.uid,
            "startTime": startTime,
            "endTime": endTime,
            "title": title,
            "content": content
        ] as [String : Any]
        return Single.create(subscribe: { single -> Disposable in
            for i in 0 ..< startToEnd.count {
                Firebase.db
                    .collection("calendar")
                    .document(AppUserDefaults.getValue(keyName: "teamId"))
                    .collection("dates")
                    .document(startToEnd[i])
                    .setData(["date": startToEnd[i]], completion: { error in
                        if let error = error {
                            single(.error(FirebaseError.fetchError(error)))
                            return
                        }
                    Firebase.db.collection("calendar")
                        .document(AppUserDefaults.getValue(keyName: "teamId"))
                        .collection("dates")
                        .document(startToEnd[i])
                        .collection("events")
                        .document(eventCollectionPath)
                        .setData(setData, completion: { error in
                            if let error = error {
                                single(.error(FirebaseError.fetchError(error)))
                                return
                            }
                        })
                    })
            }
            return Disposables.create()
        })
    }
}
