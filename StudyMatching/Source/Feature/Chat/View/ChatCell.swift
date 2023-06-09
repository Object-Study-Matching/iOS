//
//  ChatCell.swift
//  StudyMatching
//
//  Created by SeokHyun on 2023/06/07.
//

import UIKit

import SnapKit

final class ChatCell: UICollectionViewCell {
  // MARK: - Properties
  static var id: String {
    return String(describing: self)
  }
  
  private let profileImageView: UIImageView = .init().set {
    let height: CGFloat = 42
    
    $0.contentMode = .scaleAspectFill
    $0.layer.cornerRadius = height * 0.5
    $0.clipsToBounds = true
  }
  
  private let nameLabel: UILabel = .init().set {
    $0.font = .systemFont(ofSize: 14, weight: .semibold)
    $0.text = "사용자 이름"
    $0.numberOfLines = 1
    $0.textColor = .black
  }
  
  private let recentMessageLabel: UILabel = .init().set {
    $0.font = .systemFont(ofSize: 12, weight: .semibold)
    $0.text = "사용자 메세지"
    $0.numberOfLines = 1
    $0.textColor = .Palette.placeHolderColor
  }
  
  private let recentDateLabel: UILabel = .init().set {
    $0.textColor = .Palette.placeHolderColor
    $0.font = .systemFont(ofSize: 10)
    $0.text = "날짜"
  }
  
  private let memeberCountLabel: UILabel = .init().set {
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = UIColor.Palette.placeHolderColor
    $0.text = "0"
  }
  
  private let messageCountView: UIView = .init().set {
    let width: CGFloat = 18
    $0.layer.cornerRadius = width * 0.5
    $0.backgroundColor = .Palette.primary
  }
  
  private let messageCountLabel: UILabel = .init().set {
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 8)
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    memeberCountLabel.isHidden = false
    messageCountView.isHidden = false
  }
}

// MARK: - Configure
extension ChatCell {
  // letter cell
  func configure(letter model: ChatModel.LetterModel) {
    profileImageView.image = UIImage(named: model.profileImage)!
    nameLabel.text = model.userName
    recentMessageLabel.text = model.recentMessage
    recentDateLabel.text = model.recentDateString
    
    memeberCountLabel.isHidden = true
    messageCountView.isHidden = true
  }
  
  // group cell
  func configure(group model: ChatModel.GroupChatModel) {
    if let imageName = model.profileImage {
      profileImageView.image = UIImage(named: imageName)!
    } else { profileImageView.image = UIImage(systemName: "person.circle") }
    
    nameLabel.text = model.groupName
    recentMessageLabel.text = model.recentMessage
    recentDateLabel.text = model.recentDateString
    memeberCountLabel.text = "\(model.memberCount)"
    messageCountLabel.text = "\(model.messageCount)"
  }
}

// MARK: - LayoutSupport
extension ChatCell: LayoutSupport {
  func addSubviews() {
    contentView.addSubview(profileImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(memeberCountLabel)
    contentView.addSubview(recentMessageLabel)
    contentView.addSubview(recentDateLabel)
    contentView.addSubview(messageCountView)
    messageCountView.addSubview(messageCountLabel)
  }
  
  func setConstraints() {
    profileImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.size.equalTo(42)
      $0.leading.equalToSuperview().inset(8)
    }
    
    nameLabel.setContentHuggingPriority(.required, for: .horizontal)
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
    }
    
    memeberCountLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    memeberCountLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel)
      $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
      $0.trailing.lessThanOrEqualTo(recentDateLabel.snp.leading).offset(-10)
    }
    
    recentMessageLabel.snp.makeConstraints {
      $0.leading.equalTo(nameLabel)
      $0.top.equalTo(nameLabel.snp.bottom)
      $0.trailing.equalTo(messageCountView.snp.leading).offset(-10)
    }
    
    recentDateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    recentDateLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel)
      $0.trailing.equalToSuperview().inset(12)
    }
    
    messageCountView.snp.makeConstraints {
      $0.top.equalTo(recentDateLabel.snp.bottom).offset(5)
      $0.trailing.equalToSuperview().inset(18)
      $0.size.equalTo(18)
    }
    
    messageCountLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
