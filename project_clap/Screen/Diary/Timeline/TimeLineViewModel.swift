import Foundation
import RxSwift
import RxCocoa

protocol TimeLineViewModelInput {
    
}

protocol TimeLineViewModelOutput {
    var timeLineArr: Array<String> { get }
}

protocol TimeLineViewModelType {
    var inputs: TimeLineViewModelInput { get }
    var outputs: TimeLineViewModelOutput { get }
}

struct TimeLineViewModel: TimeLineViewModelType, TimeLineViewModelInput, TimeLineViewModelOutput {
    var inputs: TimeLineViewModelInput { return self }
    var outputs: TimeLineViewModelOutput { return self }
    var timeLineArr: Array<String>
    
    init() {
        timeLineArr = [
            R.string.locarizable.time_line(), R.string.locarizable.draft(), R.string.locarizable.submitted()
        ]
    }
}
