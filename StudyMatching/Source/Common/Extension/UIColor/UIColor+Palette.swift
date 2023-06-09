//
//  UIColor+Palette.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/04.
//

import UIKit

extension UIColor {
  enum Palette {
    /// C9C9C9
    static let grayLine = UIColor(hex: "#C9C9C9")
    /// C9C9C9
    static let naviBottomGrayLine = UIColor(hex: "#C9C9C9")
    /// C9C9C9
    static let placeHolderColor = UIColor(hex: "#C9C9C9")
    /// E47070
    static let primary = UIColor(hex: "#E47070")
    /// E47070
    static let primaryHalf = UIColor(hex: "#E47070").withAlphaComponent(0.5)
    /// FF0000
    static let errorRed = UIColor(hex: "#FF0000")
  }
}
