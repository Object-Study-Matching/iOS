//
//  SceneDelegate.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/05/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var MainTabBar = MainTabBarController()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainTabBar
        window?.makeKeyAndVisible()
        
    }
    
}
