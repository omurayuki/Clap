import Foundation
import RxSwift
import RxCocoa

protocol TabBarDataStore {
    func fetchUserData(uid: String) -> Single<[String]?>
}

struct TabBarDataStoreImpl: TabBarDataStore {
    func fetchUserData(uid: String) -> Single<[String]?> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db.collection("users").document(uid).getDocument { snapshot, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                ////imageも取得
                guard let data = snapshot?.data() else { return }
                guard let name = data["name"] as? String else { return }
                single(.success([name]))
            }
            return Disposables.create()
        })
    }
}
