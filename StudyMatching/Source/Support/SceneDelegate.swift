//
//  SceneDelegate.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/05/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  // 추후 userDefaults로 수정TODO: - 임시 체크 항상 false
  var isLogin = false
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    if !isLogin {
      window?.rootViewController = LoginViewController().set { $0.delegate = self }
      window?.makeKeyAndVisible()
    } else {
      gotoMainPage()
    }
  }
}

// 추후 coordinator사용한다면 지워야합니다TODO: - 임시 화면 전환
extension SceneDelegate: LoginViewControllerDelegate {
  func gotoMainPage() {
    window?.rootViewController = MainTabBarController()
    window?.makeKeyAndVisible()
  }
}
