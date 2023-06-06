//
//  UIView+TouchAnimationHalfAlphaAndBack.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

extension UIView {
  static func animateHalfAlphaAndBack(
    _ target: UIView,
    duration: CGFloat = 0.5,
    alpha: CGFloat = 0.5,
    _ completionHandler: (() -> Void)? = nil
  ) {
    target.alpha = 0.5
    animate(
      withDuration: duration,
      animations: {
        target.alpha = 1
      }) { _ in
        completionHandler?()
      }
  }
}
