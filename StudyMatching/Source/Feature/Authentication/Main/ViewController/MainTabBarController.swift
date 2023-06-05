//
//  MainTabBarController.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/04.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let homeViewController = HomeViewController()
    let chatViewController = ChatViewController()
    let alertViewController = AlertViewController()
    let profileViewController = ProfileViewContoller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarItem()
        setTabBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTabBarLayout()
    }
    
    private func setTabBarItem() {
        homeViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "house.fill"), tag: 0)
        chatViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "ellipsis.message.fill"), tag: 1)
        alertViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "bell.circle"), tag: 2)
        profileViewController.tabBarItem =
        UITabBarItem(title: nil, image: UIImage(systemName: "person.crop.circle.fill"), tag: 3)
        
        self.viewControllers =
        [homeViewController, chatViewController, alertViewController, profileViewController]
    }
    
    func setTabBar() {
        self.tabBar.tintColor = .black
        
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
    
    func setTabBarLayout() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 95
        tabFrame.origin.y = self.view.frame.size.height - 95
        self.tabBar.frame = tabFrame
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBar.backgroundColor = .black
    }
    
}