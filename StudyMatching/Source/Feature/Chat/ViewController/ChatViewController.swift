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
  private lazy var input = ChatViewModel.Input()
  private let viewModel = ChatViewModel()
  private var subscriptions = Set<AnyCancellable>()
  private lazy var tableView: UITableView = .init().set {
    $0.register(ChatCell.self, forCellReuseIdentifier: ChatCell.id)
    
    $0.dataSource = self
    $0.delegate = self
  }
  
  private let stackView: UIStackView = .init().set {
    $0.axis = .horizontal
    $0.spacing = 26
    $0.distribution = .fillEqually
  }
  
  private lazy var messageButton: UIButton = .init().set {
    $0.setTitle("쪽지", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 14)
    $0.setTitleColor(.black, for: .normal)
    $0.tintColor = .blue
    $0.layer.cornerRadius = 12
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.black.cgColor
    
    $0.addTarget(self, action: #selector(didTapMessageButton), for: .touchUpInside)
  }
  
  private lazy var studyButton: UIButton = .init().set {
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
      print("change to message section")
      changeButtonsStyle(clicked: messageButton, cleared: studyButton)
    case .changeToStudyCell:
      print("change to study section")
      changeButtonsStyle(clicked: studyButton, cleared: messageButton)
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
  }
  
  @objc private func didTapStudyButton() {
    input.didTapStudyButton.send()
  }
}

// MARK: - LayoutSupport
extension ChatViewController: LayoutSupport {
  func addSubviews() {
    navigationController?.navigationBar.addSubview(navigationBarUnderLineView)
    
    _ = [messageButton, studyButton].map { stackView.addArrangedSubview($0) }
    view.addSubview(stackView)
    view.addSubview(tableView)
  }
  
  func setConstraints() {
    stackView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
      $0.leading.trailing.equalToSuperview().inset(42)
      $0.height.equalTo(42)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview().inset(16)
    }
    
    navigationBarUnderLineView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.height.equalTo(1)
      $0.leading.trailing.equalToSuperview().inset(24)
    }
  }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return ChatModel.models.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.id, for: indexPath)
    as? ChatCell else { return UITableViewCell() }
    
    let model = ChatModel.models[indexPath.row]
    cell.configure(model)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true) // selected cell color 제거
    
    input.didSelectedCell.send()
  }
}
