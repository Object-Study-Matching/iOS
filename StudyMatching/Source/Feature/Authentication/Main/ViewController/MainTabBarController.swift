//
//  MainTabBarController.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/04.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let studyPostViewController = UINavigationController(rootViewController: StudyPostViewController())
    let chatViewController = UINavigationController(rootViewController: ChatViewController())
    let alertViewController = UINavigationController(rootViewController: AlertViewController())
    let profileViewController = UINavigationController(rootViewController: ProfileViewContoller())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItem()
        setTabBarColor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarLayout()
    }
    
    private func setTabBarItem() {
        studyPostViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        chatViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "ellipsis.message.fill"), tag: 1)
        alertViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "bell.circle"), tag: 2)
        profileViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle.fill"), tag: 3)
        
        self.viewControllers =
        [studyPostViewController, chatViewController, alertViewController, profileViewController]
    }
    
}

// MARK: - TabBarSetting

extension MainTabBarController {
    
    // TabBar의 모양을 구성하는 func
    func setTabBarLayout() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 95
        tabFrame.origin.y = self.view.frame.size.height - 95
        self.tabBar.frame = tabFrame
        
        self.tabBar.tintColor = .label
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBar.layer.borderWidth = 0.4
    }
    
    // TabBar의 Color를 구성하는 func
    func setTabBarColor() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UITabBar.appearance().barTintColor = UIColor.white
        }
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    // TabBar icon의 Color값을 변경함
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.backgroundColor = .black
    }
    
}
