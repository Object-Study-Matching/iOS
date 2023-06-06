//
//  LoginConstant.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import Foundation

struct LoginConstant {
  static let shared = LoginConstant()
  private init() {}
  
  let minIdLength = 3
  let maxIdLength = 15
  let minPwLength = 3
  let maxPwLength = 20
}
