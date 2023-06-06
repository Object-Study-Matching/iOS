//
//  LoginEntity.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import Foundation

struct LoginEntity {
  private let shared = LoginConstant.shared
  var id: String = ""
  var pw: String = ""
}

extension LoginEntity {
  var isValidId: Bool {
    (shared.minIdLength...shared.maxIdLength).contains(id.count)
  }
  
  var isValidPw: Bool {
    (shared.minPwLength...shared.maxPwLength).contains(pw.count)
  }
  
  var isValidEntity: Bool {
    isValidId && isValidPw
  }
}
