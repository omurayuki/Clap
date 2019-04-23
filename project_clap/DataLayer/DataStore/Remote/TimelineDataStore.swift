import Foundation
import RxSwift
import RxCocoa

protocol TimelineDataStore {
    func fetchDiaries() -> Single<[TimelineCellData]>
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
                var dataTitleFromFireStore = [String]()
                var dataDateFromFiewstore = [String]()
                var i = 0
                for document in snapshot.documents {
                    var data = document.data()
                    dataTitleFromFireStore.append(data["text_1"] as? String ?? "")
                    dataDateFromFiewstore.append(data["date"] as? String ?? "")
                    array.append(TimelineCellData(date: DateOperator.parseDate(dataDateFromFiewstore[i]),
                                                                    time: "21:00",
                                                                    title: dataTitleFromFireStore[i],
                                                                    name: "亀太郎",
                                                                    image: URL(string: ""),
                                                                    diaryID: ""))
                    i += 1
                }
                single(.success(array))
            }
            return Disposables.create()
        })
    }
}
