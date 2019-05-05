import Foundation
import RxSwift
import RxCocoa

protocol ReplyViewModelInput {}

protocol ReplyViewModelOutput {}

protocol ReplyViewModelType {
    var inputs: ReplyViewModelInput { get }
    var outputs: ReplyViewModelOutput { get }
}

struct ReplyViewModel: ReplyViewModelType, ReplyViewModelInput, ReplyViewModelOutput {
    var inputs: ReplyViewModelInput { return self }
    var outputs: ReplyViewModelOutput { return self }
    var replyRepository: ReplyRepository = ReplyRepositoryImpl()
    var disposeBag = DisposeBag()
    
    func submitReply(reply: String, commentId: String, completion: @escaping (String?, Error?) -> Void) {
        replyRepository.submitReply(reply: reply, commentId: commentId)
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
    
    func fetchReplies(teamId: String, diaryId: String, commentId: String, completion: @escaping (String?, Error?) -> Void) {
        replyRepository.fetchReplies(teamId: teamId, diaryId: diaryId, commentId: commentId)
            .subscribe { response in
                switch response {
                case .success(let data):
                    completion(data, nil)
                case .error(let error):
                    completion(nil, error)
                }
            }.disposed(by: disposeBag)
    }
}
