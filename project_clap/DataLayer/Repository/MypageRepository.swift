import Foundation
import RxSwift
import RealmSwift

protocol MypageRepository {
    func fetchMypageData(uid: String) -> Single<Mypage>
    func fetchDiaryData(submit: Bool, uid: String) -> Single<[TimelineCellData]>
    func updateMypageData(uid: String, updateData: [String: Any], updateTeam: [String: Any]) -> Single<String>
    func updateEmail(email: String)
}

struct MypageRepositoryImpl: MypageRepository {
    
    private let dataSrore: MypageDataStore = MypageDataStoreImpl()
    
    func fetchMypageData(uid: String) -> Single<Mypage> {
        return dataSrore.fetchMypageData(uid: uid)
    }
    
    func fetchDiaryData(submit: Bool, uid: String) -> Single<[TimelineCellData]> {
        return dataSrore.fetchDiaryData(submit: submit, uid: uid)
    }
    
    func updateMypageData(uid: String, updateData: [String: Any], updateTeam: [String: Any]) -> Single<String> {
        return dataSrore.updateMypageData(uid: uid, updateData: updateData, updateTeam: updateTeam)
    }
    
    func updateEmail(email: String) {
        dataSrore.updateEmail(email: email)
    }
}
