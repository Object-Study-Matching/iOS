//
//  AuthenticationTextField.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/04.
//

import UIKit
import Combine

protocol AuthenticationTextFieldDelegate: AnyObject {
  func textFieldDidBeginEditing(_ textField: UITextField)
  func textFieldDidEndEditing(_ textField: UITextField)
  func textFieldShouldReturn(_ textField: UITextField)
}

final class AuthenticationTextField: UIView {
  // MARK: - Constant
  typealias InputState = AuthenticationTextFieldInputState
  private var textMaxLength: Int
  private var textMinLength: Int
  
  // MARK: - Properties
  private let textField = UITextField().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.text = ""
    $0.textColor = .black
    $0.font = UIFont.systemFont(ofSize: Constant.textSize)
    $0.sizeToFit()
  }
  
  @Published private var validState: InputState = .notEditing
  
  private var subscription = Set<AnyCancellable>()
  
  weak var delegate: AuthenticationTextFieldDelegate?
  
  var accessoryView: UIView?
  
  var text: String {
    get {
      textField.text ?? ""
    }
    set {
      textField.text = newValue
    }
  }
  
  var changed: AnyPublisher<String, Never> {
    textField.changed
  }
  
  private var heightConstraint: NSLayoutConstraint!
  
  // MARK: - Lifecycle
  private override init(frame: CGRect) {
    textMaxLength = 0
    textMinLength = 0
    super.init(frame: frame)
  }
  
  convenience init(
    with placeholder: String,
    textMaxLength: Int = 30,
    textMinLength: Int = 3
  ) {
      self.init(frame: .zero)
      self.textMaxLength = textMaxLength
      self.textMinLength = textMinLength
      textField.placeholder = placeholder
      translatesAutoresizingMaskIntoConstraints = false
      setTextfieldBorderColor(.notEditing)
      layer.cornerRadius = Constant.radius
      layer.borderWidth = 1
      layer.borderColor = UIColor.Palette.grayLine.cgColor
      textField.delegate = self
      setupUI()
      bind()
      backgroundColor = .white
      setShadow()
    }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    _=subscription.map { $0.cancel() }
  }
}

// MARK: - Public helpers
extension AuthenticationTextField {
  @MainActor
  func setPlaceHolder(_ text: String) {
    textField.placeholder = text
  }
  
  @MainActor
  func setTextfieldBorderColor(_ state: InputState) {
    layer.borderColor = state.color.cgColor
  }
  
  @MainActor
  func setTextFieldHeight(_ height: CGFloat) {
    heightConstraint.isActive = false
    heightConstraint = heightAnchor.constraint(equalToConstant: height)
    heightConstraint.isActive = true
  }
  
  func setContentType(_ type: UITextContentType) {
    textField.textContentType = type
  }
  
  func hideKeyboard() {
    textField.resignFirstResponder()
  }
  
  func showKeyboard() {
    textField.becomeFirstResponder()
  }
  
  func setValidState(
    _ state: AuthenticationTextFieldInputState
  ) {
    validState = state
  }
  
  func setTextSecurityPasswordType() {
    textField.isSecureTextEntry = true
    textField.textContentType = .oneTimeCode
  }
  
  /// InputAccessoryview의 frame만 생성
  func setInputAccessoryView(with height: CGFloat) {
    accessoryView = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: UIScreen.main.bounds.width,
        height: height)).set {
          $0.translatesAutoresizingMaskIntoConstraints = false
        }
    textField.inputAccessoryView = accessoryView
  }
  
  func setNotWorkingAuthCorrectionType() {
    textField.autocorrectionType = .no
  }
  
}

// MARK: - Private Helper
private extension AuthenticationTextField {
  func bind() {
    $validState
      .receive(on: DispatchQueue.main)
      .sink {
        self.setTextfieldBorderColor($0)
      }.store(in: &subscription)
  }
  
  @MainActor
  func setShadow() {
    layer.shadowColor = UIColor.gray.cgColor
    layer.shadowOpacity = 0.2
    layer.shadowOffset = CGSize(width: 0, height: 1)
    layer.shadowRadius = 7
    layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
  }
}

// MARK: - UITextFieldDelegate
extension AuthenticationTextField: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard
      (textMinLength...textMaxLength)
        .contains((textField.text ?? "").count)
    else {
      validState = .inputExcess
      delegate?.textFieldDidEndEditing(textField)
      return
    }
    validState = .editing
    delegate?.textFieldDidEndEditing(textField)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if validState != .inputExcess {
      setTextfieldBorderColor(.notEditing)
    }
    textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespaces)
    textField.resignFirstResponder()
    delegate?.textFieldDidEndEditing(textField)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if validState != .inputExcess {
      setTextfieldBorderColor(.notEditing)
    }
    textField.text = (textField.text ?? "").trimmingCharacters(in: .whitespaces)
    textField.resignFirstResponder()
    delegate?.textFieldShouldReturn(textField)
    return true
  }
  
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    let currentText = textField.text ?? ""
    let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
    
    return newText.count <= textMaxLength
  }
  
}

// MARK: - LayoutSupport
extension AuthenticationTextField: LayoutSupport {
  func addSubviews() {
    addSubview(textField)
  }
  
  func setConstraints() {
    heightConstraint = heightAnchor.constraint(equalToConstant: 55)
    NSLayoutConstraint.activate([
      heightConstraint,
      textField.leadingAnchor.constraint(
        equalTo: leadingAnchor,
        constant: Constant.spacing.leading),
      textField.trailingAnchor.constraint(
        equalTo: trailingAnchor,
        constant: -Constant.spacing.trailing),
      textField.centerYAnchor.constraint(equalTo: centerYAnchor)])
  }
}
