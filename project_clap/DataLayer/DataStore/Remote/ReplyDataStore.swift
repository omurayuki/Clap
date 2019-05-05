import Foundation
import RxSwift
import RxCocoa
import Firebase
import FirebaseAuth

protocol ReplyDataStore {
    func submitReply(reply: String, commentId: String) -> Single<String>
    func fetchReplies(teamId: String, diaryId: String, commentId: String) -> Single<String>
}

struct ReplyDataStoreImpl: ReplyDataStore {
    func submitReply(reply: String, commentId: String) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            let replyId = RandomString.generateRandomString(length: 15)
            let setData = [
                "replyId": replyId,
                "image": UserSingleton.sharedInstance.image,
                "name": UserSingleton.sharedInstance.name,
                "userId": UserSingleton.sharedInstance.uid,
                "reply": reply,
                "time": DateFormatter.acquireCurrentTime(),
                "created_at": FieldValue.serverTimestamp(),
                ] as [String : Any]
            Firebase.db
                .collection("diary")
                .document(AppUserDefaults.getValue(keyName: "teamId"))
                .collection("diaries")
                .document(DiarySingleton.sharedInstance.diaryId)
                .collection("comments")
                .document(commentId)
                .collection("replied")
                .document(replyId)
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
                        .collection("comments")
                        .document(commentId)
                        .updateData(["replied": true])
                    single(.success("successful"))
                })
            return Disposables.create()
        })
    }
    
    func fetchReplies(teamId: String, diaryId: String, commentId: String) -> Single<String> {
        return Single.create(subscribe: { single -> Disposable in
            Firebase.db
                .collection("diary")
                .document(teamId)
                .collection("diaries")
                .document(diaryId)
                .collection("comments")
                .document(commentId)
                .collection("replied")
                .order(by: "created_at", descending: true)
                .addSnapshotListener({ snapshot, error in
                    if let error = error {
                        single(.error(error))
                        return
                    }
                    guard let snapshot = snapshot else { return }
                    let documents = snapshot.documents
                    var replyIdArr = [String](); var userIdArr = [String]()
                    var imageArr = [String](); var nameArr = [String]()
                    var timeArr = [String](); var replyArr = [String]()
                    for tuple in documents.enumerated() {
                        let data = tuple.element.data()
                        guard
                            let replyId = data["replyId"] as? String, let userId = data["userId"] as? String,
                            let image = data["image"] as? String, let name = data["name"] as? String,
                            let time = data["time"] as? String, let reply = data["reply"] as? String
                            else { return }
                        replyIdArr.append(replyId); userIdArr.append(userId)
                        imageArr.append(image); nameArr.append(name)
                        timeArr.append(time); replyArr.append(reply)
                    }
                    ReplySingleton.sharedInstance.replyId = replyIdArr; ReplySingleton.sharedInstance.userId = userIdArr
                    ReplySingleton.sharedInstance.image = imageArr; ReplySingleton.sharedInstance.name = nameArr
                    ReplySingleton.sharedInstance.time = timeArr; ReplySingleton.sharedInstance.reply = replyArr
                    single(.success("successful"))
                })
            return Disposables.create()
        })
    }
}
