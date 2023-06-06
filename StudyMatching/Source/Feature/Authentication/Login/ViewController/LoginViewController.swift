//
//  LoginViewController.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
  // MARK: - Properties
  private let loginView = LoginView()
  
  private lazy var input = Input(
    idTextFieldChanged: loginView.idTextChanged,
    pwTextFieldChanged: loginView.pwTextChanged,
    loginEvent: loginView.loginTap)
  
  private let vm = LoginViewModel()
  
  private var subscription = Set<AnyCancellable>()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loginView.setLayout(from: view)
    view.backgroundColor = .white
    loginView.loginHelperViewDelegate = self
    loginViewBind()
    bind()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    let touchLocation = touch.location(in: view)
    guard
      loginView.getIdTextFieldFrame().contains(touchLocation) ||
      loginView.getPwTextFieldFrame().contains(touchLocation)
    else {
      loginView.hideKeyboard()
      return
    }
  }
}

// MARK: - Private helper
extension LoginViewController {
  func loginViewBind() {
    loginView
      .loginTap
      .sink { _ in
        print("DEBUG: 로그인 버튼 탭")
      }.store(in: &subscription)
  }
}

// MARK: - LoginHelperViewDelegate
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

extension LoginViewController: ViewBindCase {
  typealias Input = LoginViewModel.Input
  typealias ErrorType = LoginViewModel.ErrorType
  typealias State = LoginViewModel.State
  
  func bind() {
    vm.transform(input)
      .sink { [weak self] completion in
        switch completion {
        case .finished: break
        case .failure(let error):
          self?.handleError(error)
        }
      } receiveValue: { [weak self] in
        self?.render($0)
      }.store(in: &subscription)
  }
  
  func render(_ state: LoginViewModel.State) {
    switch state {
    case .gotoMainPage:
      // 이것 원래 서버 연동할 때 로그인 진행중 state에서 동작해야 합니다.
      
      loginView.hideKeyboard()
      print("GotoMainPage")
    case .idAndPwInputGood:
      loginView.setLoginButtonWorking()
    case .idAndPwInputNotGood:
      loginView.setLoginButtonNotWorking()
      // 여기서는 뭐 문자가 너무 길다는 경고 그런거 보내야한다.
    case .idTextLengthGood:
      loginView.setIdEditingState(.editing)
    case .pwTextLengthGood:
      loginView.setPwEditingState(.editing)
    case .idTextLengthExcess:
      loginView.setIdEditingState(.inputExcess)
    case .pwTextLengthExcess:
      loginView.setPwEditingState(.inputExcess)
    case .loginExecute:
      loginView.hideKeyboard()
      print("DEBUG: 로그인 시도 중")
      // 인디케이터 보여주기 시작합니다.
    case .loginFailed:
      print("DEBUG: 로그인 실패 ")
      // 인디케이터 보여주기 끝납니다.
    case .none:
      print("DEBUG: Nothing occured")
    }
    
  }
  
  func handleError(_ error: ErrorType) {
    switch error {
    case .unexpectedError:
      print("DEBUG: UnexpectedError occured")
    }
  }
  
}
