//
//  ChatViewModel.swift
//  StudyMatching
//
//  Created by SeokHyun on 2023/06/08.
//

import Combine
import Foundation

final class ChatViewModel {
//  typealias Input = ChatViewModel.Input
//  typealias State = ChatViewModel.State
//  typealias ViewModelError = ChatViewModel.ViewModelError
  typealias Output = AnyPublisher<State, ViewModelError>
  struct Input {
    let didTapMessageButton: PassthroughSubject<Void, ViewModelError>
    let didTapStudyButton: PassthroughSubject<Void, ViewModelError>
    let didSelectedCell: PassthroughSubject<Void, Never>
    
    init(
      didTapMessageButton: PassthroughSubject<Void, ViewModelError> = .init(),
      didTapStudyButton: PassthroughSubject<Void, ViewModelError> = .init(),
      didSelectedCell: PassthroughSubject<Void, Never> = .init()
    ) {
      self.didTapMessageButton = didTapMessageButton
      self.didTapStudyButton = didTapStudyButton
      self.didSelectedCell = didSelectedCell
    }
  }
  
  enum State {
    case changeToMessageCell
    case changeToStudyCell
    case gotoMessageVC
  }
  
  enum ViewModelError: Error {
    case none
    case fatalError
    case unexpected
  }
}
// MARK: - Transform
extension ChatViewModel {
  func transform(_ input: Input) -> Output {
    return Publishers.MergeMany(
      didTapMessageButtonStream(input),
      didTapStudyButtonStream(input),
      didSelectedCellStream(input)
    )
    .eraseToAnyPublisher()
  }
  
  private func didTapMessageButtonStream(_ input: Input) -> Output {
    return input.didTapMessageButton
      .tryMap { State.changeToMessageCell }
      .mapError { $0 as? ViewModelError ?? .unexpected }
      .eraseToAnyPublisher()
  }
  
  private func didTapStudyButtonStream(_ input: Input) -> Output {
    return input.didTapStudyButton
      .tryMap { State.changeToStudyCell }
      .mapError { $0 as? ViewModelError ?? .unexpected }
      .eraseToAnyPublisher()
  }
  
  private func didSelectedCellStream(_ input: Input) -> Output {
    return input.didSelectedCell
      .map { State.gotoMessageVC }
      .setFailureType(to: ViewModelError.self)
      .eraseToAnyPublisher()
  }
}
