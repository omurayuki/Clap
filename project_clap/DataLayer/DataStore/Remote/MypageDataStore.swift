import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

protocol MypageDataStore {
    func fetchMypageData(uid: String) -> Single<Mypage>
    func fetchDiaryData(submit: Bool, uid: String) -> Single<[TimelineCellData]>
    func updateMypageData(uid: String, updateData: [String: Any], updateTeam: [String: Any]) -> Single<String>
    func updateEmail(email: String)
}

class MypageDataStoreImpl: MypageDataStore {
    func fetchMypageData(uid: String) -> Single<Mypage> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("users")
                .document(uid)
                .getDocument(completion: { (response, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                guard let document = response, document.exists else { return }
                guard let documentData = document.data() as? [String : String] else { return }
                let model = Mypage(document: documentData)
                single(.success(model))
            })
            return Disposables.create()
        })
    }
    
    func fetchDiaryData(submit: Bool, uid: String) -> Single<[TimelineCellData]> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .whereField("submit", isEqualTo: submit)
                .whereField("userId", isEqualTo: uid)
                .order(by: "created_at", descending: true)
                .addSnapshotListener { (snapshot, error) in
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
    
    func updateMypageData(uid: String, updateData: [String: Any], updateTeam: [String: Any]) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("users")
                .document(uid)
                .updateData(updateData, completion: { error in
                    if let _ = error { return }
                    Firebase.db
                        .collection("team")
                        .document(AppUserDefaults.getValue(keyName: "teamId"))
                        .updateData(updateTeam, completion: { error in
                            if let error = error {
                                single(.error(error))
                                return
                            }
                            single(.success("successful"))
                        })
            })
            return Disposables.create()
        })
    }
    
    func updateEmail(email: String) {
        Firebase.fireAuth.currentUser?.updateEmail(to: email, completion: { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        })
    }
}
