import Foundation
import RxSwift

protocol MypageViewModelInput {
}

protocol MypageViewModelOutput {
}

protocol MypageViewModeType {
    var inputs: MypageViewModelInput { get }
    var outputs: MypageViewModelOutput { get }
}

class MypageViewModel: MypageViewModeType, MypageViewModelInput, MypageViewModelOutput {
    var inputs: MypageViewModelInput { return self }
    var outputs: MypageViewModelOutput { return self }
}
