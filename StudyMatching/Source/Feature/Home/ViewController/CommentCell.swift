//
//  CommentCell.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/08.
//

import SnapKit
import UIKit

class CommentCell: UITableViewCell {
  
  let commentContainerView = UIView()
  let profileContainerView = UIView()
  let userProfileImageView: UIImageView = UIImageView().set {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 20
  }
  let userNameLabel: UILabel = UILabel().set {
    $0.font = .boldSystemFont(ofSize: 13)
    $0.textColor = .label
  }
  
  let commentLabel: UILabel = UILabel().set {
    $0.font = .boldSystemFont(ofSize: 13)
    $0.textColor = .label
  }
  let dateLabel: UILabel = UILabel().set {
    $0.font = .systemFont(ofSize: 10)
    $0.textColor = .lightGray
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupUI()
    self.separatorInset = .zero
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - LayoutSupport

extension CommentCell: LayoutSupport {
  
  func addSubviews() {
    self.addSubview(commentContainerView)
    commentContainerView.addSubview(profileContainerView)
    commentContainerView.addSubview(commentLabel)
    commentContainerView.addSubview(dateLabel)
    
    // profileContainerView 추가
    profileContainerView.addSubview(userNameLabel)
    profileContainerView.addSubview(userProfileImageView)
  }
  
  func setConstraints() {
    
    self.commentContainerView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    
    self.profileContainerView.snp.makeConstraints {
      $0.top.equalTo(commentContainerView.snp.top)
      $0.leading.equalTo(commentContainerView.snp.leading)
      $0.trailing.equalTo(commentContainerView.snp.trailing)
    }
     
    self.userProfileImageView.snp.makeConstraints {
      $0.top.equalTo(profileContainerView.snp.top).offset(5)
      $0.leading.equalTo(profileContainerView.snp.leading).offset(24)
      $0.bottom.equalTo(profileContainerView.snp.bottom).inset(5)
      $0.height.equalTo(40).priority(999)
      $0.width.equalTo(40).priority(999)
    }
    
    self.userNameLabel.snp.makeConstraints {
      $0.top.equalTo(profileContainerView.snp.top).offset(20)
      $0.leading.equalTo(userProfileImageView.snp.trailing).offset(10)
    }
    
    self.commentLabel.snp.makeConstraints {
      $0.top.equalTo(profileContainerView.snp.bottom).offset(5)
      $0.leading.equalTo(commentContainerView.snp.leading).inset(24)
      $0.height.equalTo(15)
    }
    
    self.dateLabel.snp.makeConstraints {
      $0.top.equalTo(commentLabel.snp.bottom).offset(7)
      $0.leading.equalTo(commentContainerView.snp.leading).offset(24)
      $0.bottom.equalTo(commentContainerView.snp.bottom).inset(7)
    }
    
  }
  
}
