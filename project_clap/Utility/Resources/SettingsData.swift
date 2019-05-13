import Foundation
#warning("R.string")

class AccountItem {
    
    let title: String
    
    init(title: String) {
        self.title  = title
    }
    
    class var sharedItems: [AccountItem] {
        struct Static {
            static let items = AccountItem.sharedMenuItems()
        }
        return Static.items
    }
    
    private class func sharedMenuItems() -> [AccountItem] {
        var items = [AccountItem]()
        items.append(AccountItem(title: "パスワード変更"))
        items.append(AccountItem(title: "メールアドレス変更"))
        
        return items
    }
}

class GeneralItem {
    
    let title: String
    
    init(title: String) {
        self.title  = title
    }
    
    class var sharedItems: [GeneralItem] {
        struct Static {
            static let items = GeneralItem.sharedMenuItems()
        }
        return Static.items
    }
    
    private class func sharedMenuItems() -> [GeneralItem] {
        var items = [GeneralItem]()
        items.append(GeneralItem(title: "ログアウト"))
        
        return items
    }
}
