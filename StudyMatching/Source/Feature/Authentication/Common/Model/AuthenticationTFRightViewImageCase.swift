//
//  AuthenticationTextFieldRIghtImagecase.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

enum AuthenticationTFRightViewImageCase {
  case deleteAll
  case showHiddenText
  case openAndHoldIcon
  
  var image: UIImage? {
    switch self {
    case .deleteAll: return UIImage(named: "deleteAll")
    case .showHiddenText: return UIImage(named: "showHiddenText")
    case .openAndHoldIcon: return UIImage(named: "openAndHoldIcon")
    }
  }
}
