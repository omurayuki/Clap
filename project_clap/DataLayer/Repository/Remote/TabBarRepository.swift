import Foundation
import RxSwift
import RxCocoa

protocol TabBarRepository {
    func fetchUserData(uid: String) -> Single<[String]?>
}

struct TabBarRepositoryImpl: TabBarRepository {
    
    private let dataStore: TabBarDataStore = TabBarDataStoreImpl()
    
    func fetchUserData(uid: String) -> Single<[String]?> {
        return dataStore.fetchUserData(uid: uid)
    }
}
