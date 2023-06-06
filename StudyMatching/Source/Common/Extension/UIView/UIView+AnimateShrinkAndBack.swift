//
//  UIView+AnimateShrinkAndBack.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/06/06.
//

import UIKit

extension UIView {
  static func animateShrinkAndBack(
    _ target: UIView,
    duration: CGFloat = 0.1,
    scale: CGFloat = 0.95,
    _ completionHandler: (() -> Void)? = nil
  ) {
    animate(
      withDuration: duration,
      delay: 0,
      options: .curveEaseOut,
      animations: {
        target.transform = CGAffineTransform(scaleX: scale, y: scale)
      }) { _ in
        animate(
          withDuration: duration,
          delay: 0,
          options: .curveEaseInOut,
          animations: {
            target.transform = .identity
          }) {_ in
            completionHandler?()
          }
      }
  }
}
