import Foundation
import RxSwift
import RealmSwift

protocol LoginRepository {
    func login(mail: String, pass: String) -> Single<String>
}

struct LoginRepositoryImpl: LoginRepository {
    
    private let dataStore: LoginDataStore = LoginDataStoreImpl()
    
    func login(mail: String, pass: String) -> Single<String> {
        return dataStore.login(mail: mail, pass: pass)
    }
}
