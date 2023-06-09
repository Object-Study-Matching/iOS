//
//  ChatViewController.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/04.
//

import Combine
import UIKit

import SnapKit

final class ChatViewController: UIViewController {
  // MARK: - Properties
  private var isLetterButtonTap = true
  private lazy var input = ChatViewModel.Input()
  private let viewModel = ChatViewModel()
  private var subscriptions = Set<AnyCancellable>()
  private lazy var collectionView: UICollectionView = .init(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).set {
    $0.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.id)
    $0.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    $0.dataSource = self
    $0.delegate = self
  }
  
  private let stackView: UIStackView = .init().set {
    $0.axis = .horizontal
    $0.spacing = 26
    $0.distribution = .fillEqually
  }
  
  private lazy var letterButton: UIButton = .init().set {
    $0.setTitle("쪽지", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 14)
    $0.tintColor = .blue
    $0.layer.cornerRadius = 12
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.black.cgColor
    $0.backgroundColor = .black
    $0.setTitleColor(.white, for: .normal)
    
    $0.addTarget(self, action: #selector(didTapMessageButton), for: .touchUpInside)
  }
  
  private lazy var groupChatButton: UIButton = .init().set {
    $0.setTitle("스터디", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 14)
    $0.setTitleColor(.black, for: .normal)
    $0.tintColor = .blue
    $0.layer.cornerRadius = 12
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.black.cgColor
    
    $0.addTarget(self, action: #selector(didTapStudyButton), for: .touchUpInside)
  }
  
  private let navigationBarUnderLineView: UIView = .init().set {
    $0.backgroundColor = UIColor.Palette.grayLine
  }
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupUI()
    setupStyles()
    bind()
  }
}

// MARK: - Bind
extension ChatViewController {
  private func bind() {
    let output = viewModel.transform(input)
    
    output
      .receive(on: RunLoop.main)
      .sink { [weak self] result in
        switch result {
        case .finished:
          print("finished")
        case let .failure(error):
          self?.handleError(error)
        }
      } receiveValue: { [weak self] in
        self?.render($0)
      }
      .store(in: &subscriptions)
  }
  
  private func render(_ state: ChatViewModel.State) {
    switch state {
    case .changeToMessageCell:
      changeButtonsStyle(clicked: letterButton, cleared: groupChatButton)
      collectionView.reloadData()
    case .changeToStudyCell:
      changeButtonsStyle(clicked: groupChatButton, cleared: letterButton)
      collectionView.reloadData()
    case .gotoMessageVC:
      print("push: ChatVC -> MessageVC")
    }
  }
  
  private func handleError(_ error: ChatViewModel.ViewModelError) {
    switch error {
    case .none:
      print("DEBUG: Error not occured")
    case .fatalError:
      print("DEBUG: Fatal Error occured")
    case .unexpected:
      print("DEBUG: Unexpected error occured")
    }
  }
}

// MARK: - Helpers
extension ChatViewController {
  private func changeButtonsStyle(clicked: UIButton, cleared: UIButton) {
    clicked.backgroundColor = .black
    clicked.setTitleColor(.white, for: .normal)
    cleared.backgroundColor = .white
    cleared.setTitleColor(.black, for: .normal)
  }
  
  private func setupStyles() {
    self.title = "채팅"
  }
}

// MARK: - Actions
extension ChatViewController {
  @objc private func didTapMessageButton() {
    input.didTapMessageButton.send()
    isLetterButtonTap = true
  }
  
  @objc private func didTapStudyButton() {
    input.didTapStudyButton.send()
    isLetterButtonTap = false
  }
}

// MARK: - LayoutSupport
extension ChatViewController: LayoutSupport {
  func addSubviews() {
    navigationController?.navigationBar.addSubview(navigationBarUnderLineView)
    
    _ = [letterButton, groupChatButton].map { stackView.addArrangedSubview($0) }
    view.addSubview(stackView)
    view.addSubview(collectionView)
  }
  
  func setConstraints() {
    stackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
      $0.leading.trailing.equalToSuperview().inset(42)
      $0.height.equalTo(42)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom).offset(12)
      $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
    navigationBarUnderLineView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.height.equalTo(1)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension ChatViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return viewModel.numberOfItemsInSection(isLetterButtonTap)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.id, for: indexPath)
    as? ChatCell else { return UICollectionViewCell() }
    
    if isLetterButtonTap {
      let model = viewModel.fetchLetterModel(at: indexPath.item)
      cell.configure(letter: model)
    } else {
      let model = viewModel.fetchGroupChatModel(at: indexPath.item)
      cell.configure(group: model)
    }
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ChatViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    input.didSelectedCell.send()
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(
      width: collectionView.frame.width - collectionView.contentInset.left * 2,
      height: 60
    )
  }
}
