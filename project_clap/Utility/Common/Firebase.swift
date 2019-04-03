import Foundation
import Firebase
import FirebaseAuth

struct Firebase {
    static let db = Firestore.firestore()
    static let fireAuth = Auth.auth()
}
