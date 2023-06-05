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
  }
}
