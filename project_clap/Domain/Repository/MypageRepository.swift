import Foundation
import RxSwift
import Firebase
import FirebaseAuth
import RealmSwift

class MypageRepositoryImpl {
    func fetchMypageData(uid: String) -> Single<Mypage> {
        return Single.create(subscribe: { observer -> Disposable in
            Firebase.db.collection("users").document(uid).getDocument(completion: { (response, error) in
                if let error = error {
                    observer(.error(error))
                }
                guard let document = response, document.exists else { return }
                guard let documentData = document.data() as? [String : String] else { return }
                let model = Mypage(document: documentData)
                observer(.success(model))
            })
            return Disposables.create()
        })
    }
}
