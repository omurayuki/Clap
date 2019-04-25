import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    private let viewModel = TabBarViewModel()
    var calendarVC: DisplayCalendarViewController
    var timeLineVC: TimeLineViewController
    var mypageVC: MypageViewController
    
    init(calendar: DisplayCalendarViewController, timeLine: TimeLineViewController, mypage: MypageViewController) {
        calendarVC = calendar
        timeLineVC = timeLine
        mypageVC = mypage
        super.init(nibName: nil, bundle: nil)
        fetchUserData(uid: UserSingleton.sharedInstance.uid)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
}

extension TabBarController {
    private func setupTab() {
        tabBar.barStyle = .default
        tabBar.clipsToBounds = true
        var viewControllers: [UIViewController] = []
        var navi = UINavigationController(rootViewController: calendarVC)
        navi.tabBarItem = UITabBarItem(title: R.string.locarizable.calendar(), image: #imageLiteral(resourceName: "calendar-7"), tag: TabBarResources.View.calendartag)
        viewControllers.append(navi)
        
        navi = UINavigationController(rootViewController: timeLineVC)
        navi.tabBarItem = UITabBarItem(title: R.string.locarizable.diary(), image: #imageLiteral(resourceName: "note-write-7"), tag: TabBarResources.View.diaryTag)
        viewControllers.append(navi)
        
        navi = UINavigationController(rootViewController: mypageVC)
        navi.tabBarItem = UITabBarItem(title: R.string.locarizable.mypage(), image: #imageLiteral(resourceName: "home-7"), tag: TabBarResources.View.mypageTag)
        viewControllers.append(navi)
        
        setViewControllers(viewControllers, animated: false)
        selectedIndex = TabBarResources.View.selectedIndex
    }
    
    func fetchUserData(uid: String) {
        viewModel.fetchUserData(uid: uid) { (data, error) in
            if let _ = error {
                AlertController.showAlertMessage(alertType: .loginFailed, viewController: self)
                return
            }
            UserSingleton.sharedInstance.name = data?[0] ?? ""
        }
    }
}
