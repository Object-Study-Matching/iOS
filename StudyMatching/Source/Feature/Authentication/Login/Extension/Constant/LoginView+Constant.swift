//
//  Constant.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

extension LoginView {
  enum Constant {
    enum AppTitleLabel {
      static let textSize = 24.0
      static let spacing: UISpacing = .init(top: 65)
      static let text = "스터디 매칭 앱"
      static let textColor = UIColor.black
    }
    
    enum IdTextfield {
      static let textMaxLength = 20
      static let textMinLength = 3
      static let spacing: UISpacing = .init(leading: 24, top: 65, trailing: 24)
    }
    
    enum PwTextfield {
      static let textMaxLength = 20
      static let textMinLength = 3
      static let spacing: UISpacing = .init(leading: 24, top: 12, trailing: 24)
    }
    
    enum LoginButton {
      static let textSize = 14.0
      static let spacing: UISpacing = .init(leading: 24, top: 12, trailing: 24)
      static let textBGColor = UIColor.Palette.primary
      static let textColor = UIColor.white
      static let height = 55.0
      static let cornerRadius = 8.0
    }
    
    enum LoginHelperView {
      static let spacing: UISpacing = .init(top: 12)
    }
  }
}
