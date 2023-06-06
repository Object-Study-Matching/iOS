//
//  LoginHelperView+Constant.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

extension LoginHelperView {
  enum Constant {
    enum PwLabel {
      static let textColor = UIColor.Palette.placeHolderColor
      static let text = "비밀번호 찾기"
      static let textSize = 12.0
    }
    
    enum IdLabel {
      static let textColor = UIColor.Palette.placeHolderColor
      static let text = "아이디 찾기"
      static let textSize = 12.0
      static let spacing: UISpacing = .init(leading: 16)
    }
    
    enum SignUpLabel {
      static let textColor = UIColor.Palette.primary
      static let text = "회원가입"
      static let textSize = 12.0
      static let spacing: UISpacing = .init(leading: 16)
    }
    
    enum SpaceView {
      static let bgColor = UIColor.Palette.placeHolderColor
      static let size = CGSize(width: 1, height: 12)
      static let spacing: UISpacing = .init(leading: 16)
    }
  }
}
