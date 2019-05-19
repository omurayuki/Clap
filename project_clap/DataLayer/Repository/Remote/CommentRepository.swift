import Foundation
import RxSwift
import RxCocoa

protocol CommentRepository {
    func submitComment(comment: String) -> Single<String>
    func fetchComment() -> Single<String>
}

struct CommentRepositoryImpl: CommentRepository {
    
    private let dataStore: CommentDataStore = CommentDataStoreImpl()
    
    func submitComment(comment: String) -> Single<String> {
        return dataStore.submitComment(comment: comment)
    }
    
    func fetchComment() -> Single<String> {
        return dataStore.fetchComment()
    }
}
