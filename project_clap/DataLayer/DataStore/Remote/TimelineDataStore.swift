import Foundation
import RxSwift
import RxCocoa

protocol TimelineDataStore {
    func fetchDiaries() -> Single<[TimelineCellData]>
    func fetchIndividualDiaries(submit: Bool, uid: String) -> Single<[TimelineCellData]>
}

class TimelineDataStoreImpl: TimelineDataStore {
    
    func fetchDiaries() -> Single<[TimelineCellData]> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .whereField("submit", isEqualTo: true)
                .getDocuments { (snapshot, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let snapshot = snapshot else { return }
                var array = [TimelineCellData]()
                var title = [String]()
                var date = [String]()
                var time = [String]()
                var name = [String]()
                var diaryId = [String]()
                    var submit = [Bool]()
                var userId = [String]()
                var i = 0
                for document in snapshot.documents {
                    var data = document.data()
                    title.append(data["text_1"] as? String ?? "")
                    date.append(data["date"] as? String ?? "")
                    time.append(data["time"] as? String ?? "")
                    name.append(data["name"] as? String ?? "")
                    userId.append(data["userId"] as? String ?? "")
                    submit.append(data["submit"] as? Bool ?? Bool())
                    diaryId.append(data["diaryId"] as? String ?? "")
                    array.append(TimelineCellData(date: DateOperator.parseDate(date[i]),
                                                                    time: time[i],
                                                                    title: title[i],
                                                                    name: name[i],
                                                                    image: URL(string: ""),
                                                                    userId: userId[i],
                                                                    submit: submit[i],
                                                                    diaryID: diaryId[i]))
                    i += 1
                }
                single(.success(array))
            }
            return Disposables.create()
        })
    }
    
    func fetchIndividualDiaries(submit: Bool, uid: String) -> Single<[TimelineCellData]> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .whereField("submit", isEqualTo: submit)
                .whereField("userId", isEqualTo: uid)
                .getDocuments { (snapshot, error) in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    guard let snapshot = snapshot else { return }
                    var array = [TimelineCellData]()
                    var title = [String]()
                    var date = [String]()
                    var time = [String]()
                    var name = [String]()
                    var diaryId = [String]()
                    var submit = [Bool]()
                    var userId = [String]()
                    var i = 0
                    for document in snapshot.documents {
                        var data = document.data()
                        title.append(data["text_1"] as? String ?? "")
                        date.append(data["date"] as? String ?? "")
                        time.append(data["time"] as? String ?? "")
                        name.append(data["name"] as? String ?? "")
                        userId.append(data["userId"] as? String ?? "")
                        submit.append(data["submit"] as? Bool ?? Bool())
                        diaryId.append(data["diaryId"] as? String ?? "")
                        array.append(TimelineCellData(date: DateOperator.parseDate(date[i]),
                                                      time: time[i],
                                                      title: title[i],
                                                      name: name[i],
                                                      image: URL(string: ""),
                                                      userId: userId[i],
                                                      submit: submit[i],
                                                      diaryID: diaryId[i]))
                        i += 1
                    }
                    single(.success(array))
            }
            return Disposables.create()
        })
    }
}
