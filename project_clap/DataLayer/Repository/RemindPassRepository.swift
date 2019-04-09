import Foundation
import RxSwift
import RealmSwift

protocol RemindPassRepository {
    func resettingPassword(mail: String) -> Single<String>
}

struct RemindPassRepositoryImpl: RemindPassRepository {
    
    private let dataStore: RemindPassDataStore = RemindPassDataStoreImpl()
    
    func resettingPassword(mail: String) -> Single<String> {
        return dataStore.resettingPassword(mail: mail)
    }
}
