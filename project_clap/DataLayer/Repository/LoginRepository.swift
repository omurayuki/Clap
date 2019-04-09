import Foundation
import RxSwift
import RealmSwift

protocol LoginRepository {
    func login(mail: String, pass: String, completion: ((String?, Error?) -> Void)?)
}

struct LoginRepositoryImpl: LoginRepository {
    
    private let dataSrore: LoginDataStore = LoginDataStoreImpl()
    
    func login(mail: String, pass: String, completion: ((String?, Error?) -> Void)? = nil) {
        dataSrore.login(mail: mail, pass: pass, completion: completion)
    }
}
