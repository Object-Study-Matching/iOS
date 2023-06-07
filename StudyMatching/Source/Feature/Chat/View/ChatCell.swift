//
//  ChatCell.swift
//  StudyMatching
//
//  Created by SeokHyun on 2023/06/07.
//

import UIKit

import SnapKit

final class ChatCell: UITableViewCell {
  // MARK: - Properties
  static var id: String {
    return String(describing: self)
  }
  
  private let profileImageView: UIImageView = .init().set {
    let height: CGFloat = 42
    
    $0.contentMode = .scaleToFill
    $0.layer.cornerRadius = height * 0.5
    $0.clipsToBounds = true
  }
  
  private let userNameLabel: UILabel = .init().set {
    $0.font = .systemFont(ofSize: 14, weight: .semibold)
    $0.text = "사용자 이름"
    $0.numberOfLines = 1
    $0.textColor = .black
  }
  
  private let descriptionLabel: UILabel = .init().set {
    $0.font = .systemFont(ofSize: 12, weight: .semibold)
    $0.text = "사용자 메세지"
    $0.numberOfLines = 1
    $0.textColor = .Palette.placeHolderColor
  }
  
  private let dateLabel: UILabel = .init().set {
    $0.textColor = .Palette.placeHolderColor
    $0.font = .systemFont(ofSize: 10)
    $0.text = "방금 전"
  }
  
  // MARK: - LifeCycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Configure
extension ChatCell {
  func configure(_ chat: ChatModel) {
    profileImageView.image = UIImage(named: "2fb3451f2790627112ebba6732cb7a49")!
    userNameLabel.text = chat.userName
    descriptionLabel.text = chat.description
    dateLabel.text = chat.dateString
  }
}

// MARK: - LayoutSupport
extension ChatCell: LayoutSupport {
  func addSubviews() {
    contentView.addSubview(profileImageView)
    contentView.addSubview(userNameLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(dateLabel)
  }
  
  func setConstraints() {
    profileImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.size.equalTo(42)
      $0.leading.equalToSuperview().inset(8)
    }
    
    userNameLabel.snp.makeConstraints {
      $0.top.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
      $0.trailing.lessThanOrEqualTo(dateLabel.snp.leading).offset(-20)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(userNameLabel)
      $0.top.equalTo(userNameLabel.snp.bottom)
      $0.trailing.equalTo(userNameLabel)
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(6)
      $0.trailing.equalToSuperview().inset(12)
    }
    
    dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
  }
}
