//
//  LoginViewModel.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import Foundation
import Combine

final class LoginViewModel {
  // MARK: - Properties
  var loginEntity = LoginEntity()
}

extension LoginViewModel: ViewModelCase {
  func transform(_ input: Input) -> Output {
    Publishers
      .MergeMany
      .init([
        idTextFieldChangedStream(input),
        pwTextFieldStream(input),
        idAndPwValidationStream(input),
        loginEventStream(input)])
      .eraseToAnyPublisher()
  }
}

// MARK: - Input operator stream
private extension LoginViewModel {
  func idTextFieldChangedStream(_ input: Input) -> Output {
    input
      .idTextFieldChanged
      .map { string -> State in
        let shared = LoginConstant.shared
        guard (shared.minIdLength...shared.maxIdLength)
          .contains(string.count)
        else {
          return .idTextLengthExcess
        }
        return .idTextLengthGood
      }
      .setFailureType(to: ErrorType.self)
      .eraseToAnyPublisher()
  }
  
  func pwTextFieldStream(_ input: Input) -> Output {
    input
      .pwTextFieldChanged
      .map { string -> State in
        let shared = LoginConstant.shared
        guard (shared.minPwLength...shared.maxPwLength)
          .contains(string.count)
        else {
          return .pwTextLengthExcess
        }
        return .pwTextLengthGood
      }
      .setFailureType(to: ErrorType.self)
      .eraseToAnyPublisher()
  }
  
  func idAndPwValidationStream(_ input: Input) -> Output {
    input
      .idTextFieldChanged
      .combineLatest(input.pwTextFieldChanged)
      .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
      .map {[weak self] id, pw -> State in
        let shared = LoginConstant.shared
        guard
          (shared.minIdLength...shared.maxIdLength)
            .contains(id.count) &&
            (shared.minPwLength...shared.maxPwLength)
            .contains(pw.count)
        else {
          return .idAndPwInputNotGood
        }
        self?.loginEntity.id = id
        self?.loginEntity.pw = pw
        return .idAndPwInputGood
      }.setFailureType(to: ErrorType.self)
      .eraseToAnyPublisher()
  }
  
  func loginEventStream(_ input: Input) -> Output {
    input
      .loginEvent
      .map { _ -> State in
        // 여기서 서버에 로그인 이벤트 보낸 후 다시 isSuccess결과 출력에 따라
        // 다음화면.
        // 지금은 그냥 로그인 성공했다고 가정
        return .gotoMainPage
      }.setFailureType(to: ErrorType.self)
      .eraseToAnyPublisher()
  }
}
