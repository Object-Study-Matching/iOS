//
//  LoginViewController.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

final class LoginViewController: UIViewController {
  // MARK: - Properties
  private let loginView = LoginView()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loginView.setLayout(from: view)
    view.backgroundColor = .white
    loginView.loginHelperViewDelegate = self
  }
}



extension LoginViewController: LoginHelperViewDelegate {
  func gotoFindPassword() {
    print("DEBUG: 비번 찾기 화면 전환")
  }
  
  func gotoFindId() {
    print("DEBUG: 아이디 찾기 화면 전환")
  }
  
  func gotoSignUp() {
    print("DEBUG: 회원가입 화면 전환")
  }
  
  
}
