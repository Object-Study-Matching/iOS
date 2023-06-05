//
//  LoginHelperView.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

final class LoginHelperView: UIView {
  // MARK: - Properties
  weak var delegate: LoginHelperViewDelegate?
  
  private let pwLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = Constant.PwLabel.text
    $0.textColor = Constant.PwLabel.textColor
    $0.font = .systemFont(ofSize: Constant.PwLabel.textSize)
    $0.sizeToFit()
  }
  
  private let idLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = Constant.IdLabel.text
    $0.textColor = Constant.IdLabel.textColor
    $0.font = .systemFont(ofSize: Constant.IdLabel.textSize)
    $0.sizeToFit()
  }
  
  private let spaceViews = (0..<2).map {_ -> UIView in
    return UIView().set {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = Constant.SpaceView.bgColor
    }
  }
  
  private let signUpLabel = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = Constant.SignUpLabel.text
    $0.textColor = Constant.SignUpLabel.textColor
    $0.font = .systemFont(ofSize: Constant.SignUpLabel.textSize)
    $0.sizeToFit()
  }
  
  // MARK: - LifeCycle
  private override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  convenience init() {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    addTapGesture(idLabel, with: #selector(tapId))
    addTapGesture(pwLabel, with: #selector(tapPw))
    addTapGesture(signUpLabel, with: #selector(tapSignUp))
    setupUI()
  }
}

// MARK: - Action
extension LoginHelperView {
  @objc func tapPw() {
    delegate?.gotoFindPassword()
  }
  
  @objc func tapId() {
    delegate?.gotoFindId()
  }
  
  @objc func tapSignUp() {
    delegate?.gotoSignUp()
  }
}

// MARK: - Private helper
private extension LoginHelperView {
  func addTapGesture(_ view: UIView, with action: Selector) {
    view.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: action)
    view.addGestureRecognizer(tap)
  }
}

// MARK: - LayoutSupport
extension LoginHelperView: LayoutSupport {
  func addSubviews() {
    _=[pwLabel, spaceViews[0], idLabel, spaceViews[1], signUpLabel].map {
      addSubview($0)
    }
  }
  
  func setConstraints() {
    _=[pwLabelConstraints,
       spaceViewZeroConstraints,
       idLabelConstraints,
       spaceViewOneConstraints,
       SignUpLabelConstraints]
      .map {
        NSLayoutConstraint.activate($0)
    }
  }
}
// MARK: - Layout support helper
extension LoginHelperView {
  var pwLabelConstraints: [NSLayoutConstraint] {
    [pwLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
     pwLabel.topAnchor.constraint(equalTo: topAnchor),
     pwLabel.bottomAnchor.constraint(equalTo: bottomAnchor)]
  }
  
  var spaceViewZeroConstraints: [NSLayoutConstraint] {
    [spaceViews[0].leadingAnchor.constraint(
      equalTo: pwLabel.trailingAnchor,
      constant: Constant.SpaceView.spacing.leading),
     spaceViews[0].heightAnchor.constraint(
      equalToConstant: Constant.SpaceView.size.height),
     spaceViews[0].widthAnchor.constraint(
      equalToConstant: Constant.SpaceView.size.width),
     spaceViews[0].centerYAnchor.constraint(
      equalTo: pwLabel.centerYAnchor)]
  }
  
  var idLabelConstraints: [NSLayoutConstraint] {
    [idLabel.leadingAnchor.constraint(
      equalTo: spaceViews[0].trailingAnchor,
      constant: Constant.IdLabel.spacing.leading),
     idLabel.centerYAnchor.constraint(equalTo: pwLabel.centerYAnchor)]
  }
  
  var spaceViewOneConstraints: [NSLayoutConstraint] {
    [spaceViews[1].leadingAnchor.constraint(
      equalTo: idLabel.trailingAnchor,
      constant: Constant.SpaceView.spacing.leading),
     spaceViews[1].heightAnchor.constraint(
      equalToConstant: Constant.SpaceView.size.height),
     spaceViews[1].widthAnchor.constraint(
      equalToConstant: Constant.SpaceView.size.width),
     spaceViews[1].centerYAnchor.constraint(equalTo: pwLabel.centerYAnchor)]
  }
  
  var SignUpLabelConstraints: [NSLayoutConstraint] {
    [signUpLabel.leadingAnchor.constraint(
      equalTo: spaceViews[1].trailingAnchor,
      constant: Constant.SignUpLabel.spacing.leading),
     signUpLabel.centerYAnchor.constraint(equalTo: pwLabel.centerYAnchor),
     signUpLabel.trailingAnchor.constraint(equalTo: trailingAnchor)]
  }
}
