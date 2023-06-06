//
//  LoginViewModel+Associatedtype.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import Combine

extension LoginViewModel: ViewModelAssociatedType {
  struct Input {
    let idTextFieldChanged: AnyPublisher<String, Never>
    let pwTextFieldChanged: AnyPublisher<String, Never>
    let loginEvent: AnyPublisher<Void, Never>
    
    init(
      idTextFieldChanged: AnyPublisher<String, Never>,
      pwTextFieldChanged: AnyPublisher<String, Never>,
      loginEvent: AnyPublisher<Void,Never>
    ) {
      self.idTextFieldChanged = idTextFieldChanged
      self.pwTextFieldChanged = pwTextFieldChanged
      self.loginEvent = loginEvent
    }
  }
  
  enum ErrorType: Error {
    case unexpectedError
  }
  
  enum State {
    case idTextLengthExcess
    case pwTextLengthExcess
    case idTextLengthGood
    case pwTextLengthGood
    case loginFailed
    case loginExecute
    case idAndPwInputGood
    case idAndPwInputNotGood
    case gotoMainPage
    case none
  }
  
  typealias Output = AnyPublisher<State, ErrorType>
}
