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
    func loadEvent() -> Observable<Result<[String: [String]], FirebaseError>>
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
            startToEnd.enumerated().forEach { index, _ in
                Firebase.db
                    .collection("calendar")
                    .document(AppUserDefaults.getValue(keyName: "teamId"))
                    .collection("dates")
                    .document(startToEnd[index])
                    .setData(["date": startToEnd[index]], completion: { error in
                    if let error = error {
                        single(.error(FirebaseError.fetchError(error)))
                        return
                    }
                    Firebase.db.collection("calendar")
                        .document(AppUserDefaults.getValue(keyName: "teamId"))
                        .collection("dates")
                        .document(startToEnd[index])
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
    
    func loadEvent() -> Observable<Result<[String: [String]], FirebaseError>> {
        return Observable.create({ observer -> Disposable in
            var returnArray = [String: [String]]()
            Firebase.db
                .collection("calendar")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("dates")
                .addSnapshotListener({ snapshot, error in
                    if let e = error {
                        observer.on(.error(FirebaseError.fetchError(e)))
                        return
                    }
                    guard let documents = snapshot?.documents else { return }
                    for document in documents {
                        guard let date = document["date"] as? String else { return }
                        returnArray.updateValue([String](), forKey: date)
                        Firebase.db
                            .collection("calendar")
                            .document(AppUserDefaults.getValue(keyName: "teamId"))
                            .collection("dates")
                            .document(date)
                            .collection("events")
                            .addSnapshotListener({ eventsSnapshot, error in
                                guard let eventsDocuments = eventsSnapshot?.documents else { return }
                                returnArray[date] = [String]()
                                for eventsDocument in eventsDocuments {
                                    guard let title = eventsDocument["title"] as? String else { return }
                                    returnArray[date]?.append(title)
                                    observer.on(.next(.success(returnArray)))
                                }
                            })
                    }
                    
                })
            return Disposables.create()
        })
    }
}
