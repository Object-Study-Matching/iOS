//
//  LoginView.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit
import Combine

final class LoginView: UIView {
  // MARK: - Properties
  private let appTitleLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .boldSystemFont(ofSize: Constant.AppTitleLabel.textSize)
    $0.text = Constant.AppTitleLabel.text
    $0.textColor = Constant.AppTitleLabel.textColor
  }
  
  private let idTextfield: AuthenticationTextField
  
  private let pwTextfield: AuthenticationTextField
  
  private let loginButton: UIButton = UIButton().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = Constant.LoginButton.textBGColor
    $0.layer.cornerRadius = Constant.LoginButton.cornerRadius
    let attrStr = NSMutableAttributedString(string: "로그인")
    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: Constant.LoginButton.textColor,
      .kern: -0.41,
      .font: UIFont.boldSystemFont(ofSize: Constant.LoginButton.textSize)]
    attrStr.addAttributes(
      attributes,
        range: NSRange(location: 0, length: "로그인".count))
    $0.setAttributedTitle(attrStr, for: .normal)
  }
  
  private let loginHelperView = LoginHelperView()
  
  // MARK: - Computed properties
  var idTextChanged: AnyPublisher<String, Never> {
    idTextfield.changed
  }
  
  var pwTextChanged: AnyPublisher<String, Never> {
    pwTextfield.changed
  }
  
  var loginTap: AnyPublisher<Void, Never> {
    loginButton.tap
  }
  
  var loginHelperViewDelegate: LoginHelperViewDelegate? {
    loginHelperView.delegate
  }
  // MARK: - LifeCycle
  private override init(frame: CGRect) {
    idTextfield = AuthenticationTextField(
      with: "아이디",
      textMaxLength: Constant.IdTextfield.textMaxLength,
      textMinLength: Constant.IdTextfield.textMinLength)
    pwTextfield  = AuthenticationTextField(
      with: "비밀번호",
      textMaxLength: Constant.PwTextfield.textMaxLength,
      textMinLength: Constant.PwTextfield.textMinLength)
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  convenience init() {
    self.init(frame: .zero)
    setupUI()
  }
}

// MARK: - Helper
extension LoginView {
  func setLayout(from superView: UIView) {
    superView.addSubview(self)
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(
        equalTo: superView.leadingAnchor),
      topAnchor.constraint(
        equalTo: superView.safeAreaLayoutGuide.topAnchor),
      trailingAnchor.constraint(
        equalTo: superView.trailingAnchor),
      bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor)])
  }
}
// MARK: - LayoutSupport

extension LoginView: LayoutSupport {
  func addSubviews() {
    _=[appTitleLabel, idTextfield, pwTextfield, loginButton, loginHelperView]
      .map {
      addSubview($0)
    }
  }
  
  func setConstraints() {
    _=[appTitleLabelConstraints,
       idTextfieldConstraints,
       pwTextfieldConstraints,
       loginButtonConstraints,
       loginHelperViewConstraints]
      .map {
        NSLayoutConstraint.activate($0)
      }
  }
}

// MARK: - Layout support helper
private extension LoginView {
  var appTitleLabelConstraints: [NSLayoutConstraint] {
    [appTitleLabel.topAnchor.constraint(
      equalTo: topAnchor,
      constant: Constant.AppTitleLabel.spacing.top),
     appTitleLabel.centerXAnchor.constraint(
      equalTo: centerXAnchor)]
  }
  
  var idTextfieldConstraints: [NSLayoutConstraint] {
    [idTextfield.topAnchor.constraint(
      equalTo: appTitleLabel.bottomAnchor,
      constant: Constant.IdTextfield.spacing.top),
     idTextfield.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.IdTextfield.spacing.leading),
     idTextfield.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.IdTextfield.spacing.trailing)]
  }
  
  var pwTextfieldConstraints: [NSLayoutConstraint] {
    [pwTextfield.topAnchor.constraint(
      equalTo: idTextfield.bottomAnchor,
      constant: Constant.PwTextfield.spacing.top),
     pwTextfield.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.PwTextfield.spacing.leading),
     pwTextfield.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.PwTextfield.spacing.trailing)]
  }
  
  var loginButtonConstraints: [NSLayoutConstraint] {
    [loginButton.topAnchor.constraint(
      equalTo: pwTextfield.bottomAnchor,
      constant: Constant.LoginButton.spacing.top),
     loginButton.leadingAnchor.constraint(
      equalTo: leadingAnchor,
      constant: Constant.LoginButton.spacing.leading),
     loginButton.trailingAnchor.constraint(
      equalTo: trailingAnchor,
      constant: -Constant.LoginButton.spacing.trailing),
     loginButton.heightAnchor.constraint(
      equalToConstant: Constant.LoginButton.height)]
  }
  
  var loginHelperViewConstraints: [NSLayoutConstraint] {
    [loginHelperView.topAnchor.constraint(
      equalTo: loginButton.bottomAnchor,
      constant: Constant.LoginHelperView.spacing.top),
     loginHelperView.centerXAnchor.constraint(equalTo: centerXAnchor)]
  }
}
