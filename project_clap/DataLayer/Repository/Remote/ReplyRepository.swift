import Foundation
import RxSwift
import RxCocoa

protocol ReplyRepository {
    func submitReply(reply: String, commentId: String) -> Single<String>
    func fetchReplies(teamId: String, diaryId: String, commentId: String) -> Single<String>
}

struct ReplyRepositoryImpl: ReplyRepository {
    
    let dataStore: ReplyDataStore = ReplyDataStoreImpl()
    
    func submitReply(reply: String, commentId: String) -> Single<String> {
        return dataStore.submitReply(reply: reply, commentId: commentId)
    }
    
    func fetchReplies(teamId: String, diaryId: String, commentId: String) -> Single<String> {
        return dataStore.fetchReplies(teamId: teamId, diaryId: diaryId, commentId: commentId)
    }
}
