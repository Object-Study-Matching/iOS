//
//  ViewModelProtocols.swift
//  StudyMatching
//
//  Created by 양승현 on 2023/05/05.
//

protocol ViewBindCase {
  /// View UI render state
  associatedtype State
  func bind()
  func render(_ state: State)
}

protocol ViewModelAssociatedType {
  /// View's event publishers structure
  associatedtype Input
  /// View's render state publihser
  associatedtype Output
  /// View's render state
  associatedtype State
}

protocol ViewModelCase: ViewModelAssociatedType {
  /// Transform view's event publihsers to 1 output publhiser with UI render state
  func transform(_ input: Input) -> Output
}
