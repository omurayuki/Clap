import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    private var calendarVC: DisplayCalendarViewController!
    private var diaryVC: DiaryGroupViewController!
    private var mypageVC: MypageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab()
    }
}

extension TabBarController {
    private func setupTab() {
        var viewControllers: [UIViewController] = []
        calendarVC = DisplayCalendarViewController()
        var navi = UINavigationController(rootViewController: calendarVC)
        navi.tabBarItem = UITabBarItem(title: "calendar", image: nil, tag: 1)
        viewControllers.append(navi)
        diaryVC = DiaryGroupViewController()
        navi = UINavigationController(rootViewController: diaryVC)
        navi.tabBarItem = UITabBarItem(title: "diary", image: nil, tag: 2)
        viewControllers.append(navi)
        mypageVC = MypageViewController()
        navi = UINavigationController(rootViewController: mypageVC)
        navi.tabBarItem = UITabBarItem(title: "mypage", image: nil, tag: 3)
        viewControllers.append(navi)
        setViewControllers(viewControllers, animated: false)
        selectedIndex = 1
    }
}
