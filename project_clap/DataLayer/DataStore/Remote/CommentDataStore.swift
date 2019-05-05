import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

protocol CommentDataStore {
    func submitComment(comment: String) -> Single<String>
    func fetchComment() -> Single<String>
}

struct CommentDataStoreImpl: CommentDataStore {
    func submitComment(comment: String) -> Single<String> {
        return Single.create { single -> Disposable in
            let commentId = RandomString.generateRandomString(length: 15)
            let setData = [
                "commentId": commentId,
                "image": UserSingleton.sharedInstance.image,
                "name": UserSingleton.sharedInstance.name,
                "userId": UserSingleton.sharedInstance.uid,
                "comment": comment,
                "time": DateFormatter.acquireCurrentTime(),
                "replied": false,
                "created_at": FieldValue.serverTimestamp(),
                ] as [String : Any]
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .document(DiarySingleton.sharedInstance.diaryId)
                .collection("comments")
                .document(commentId)
                .setData(setData, completion: { error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    Firebase.db
                        .collection("diary")
                        .document(AppUserDefaults.getValue(keyName: "teamId"))
                        .collection("diaries")
                        .document(DiarySingleton.sharedInstance.diaryId)
                        .updateData(["commented": true])
                    single(.success("successful"))
                })
            return Disposables.create()
        }
    }
    
    func fetchComment() -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .document(DiarySingleton.sharedInstance.diaryId)
                .collection("comments")
                .order(by: "created_at", descending: true)
                .addSnapshotListener({ snapshot, error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    guard let snapshot = snapshot else { return }
                    let documents = snapshot.documents
                    var commentIdArr = [String](); var userIdArr = [String]()
                    var imageArr = [String](); var nameArr = [String]()
                    var timeArr = [String](); var commentArr = [String]()
                    var repliedArr = [Bool]()
                    for tuple in documents.enumerated() {
                        let data = tuple.element.data()
                        guard
                            let commentId = data["commentId"] as? String, let userId = data["userId"] as? String,
                            let image = data["image"] as? String, let name = data["name"] as? String,
                            let time = data["time"] as? String, let comment = data["comment"] as? String,
                            let replied = data["replied"] as? Bool
                            else { return }
                        commentIdArr.append(commentId); userIdArr.append(userId)
                        imageArr.append(image); nameArr.append(name)
                        timeArr.append(time); commentArr.append(comment)
                        repliedArr.append(replied)
                    }
                    CommentSingleton.sharedInstance.commentId = commentIdArr; CommentSingleton.sharedInstance.userId = userIdArr
                    CommentSingleton.sharedInstance.image = imageArr; CommentSingleton.sharedInstance.name = nameArr
                    CommentSingleton.sharedInstance.time = timeArr; CommentSingleton.sharedInstance.comment = commentArr
                    CommentSingleton.sharedInstance.replied = repliedArr
                    single(.success("successful"))
                })
            return Disposables.create()
        })
    }
}
