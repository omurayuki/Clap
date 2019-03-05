import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var calendarVC: DisplayCalendarViewController
    var diaryVC: DiaryGroupViewController
    var mypageVC: MypageViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
    
    init(calendar: DisplayCalendarViewController, diary: DiaryGroupViewController, mypage: MypageViewController) {
        calendarVC = calendar
        diaryVC = diary
        mypageVC = mypage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TabBarController {
    private func setupTab() {
        var viewControllers: [UIViewController] = []
        var navi = UINavigationController(rootViewController: calendarVC)
        navi.tabBarItem = UITabBarItem(title: R.string.locarizable.calendar(), image: nil, tag: TabBarResources.View.calendartag)
        viewControllers.append(navi)
        
        navi = UINavigationController(rootViewController: diaryVC)
        navi.tabBarItem = UITabBarItem(title: R.string.locarizable.diary(), image: nil, tag: TabBarResources.View.diaryTag)
        viewControllers.append(navi)
        
        navi = UINavigationController(rootViewController: mypageVC)
        navi.tabBarItem = UITabBarItem(title: R.string.locarizable.mypage(), image: nil, tag: TabBarResources.View.mypageTag)
        viewControllers.append(navi)
        
        setViewControllers(viewControllers, animated: false)
        selectedIndex = TabBarResources.View.selectedIndex
    }
}
