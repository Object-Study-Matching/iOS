//
//  StudyMatchingPostCell.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/05.
//

import SnapKit
import UIKit

class StudyPostCell: UITableViewCell {
    
    // MARK: - Properties
    
    let profileContainerView = UIView()
    lazy var profileImageView = UIImageView().set {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 22
    }
    let userNameLabel: UILabel = UILabel().set {
        $0.font = .boldSystemFont(ofSize: 13)
    }
    let postedAtLabel: UILabel = UILabel().set {
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .lightGray
    }
    
    let postContainerView = UIView()
    let titleLabel: UILabel = UILabel().set {
        $0.font = .boldSystemFont(ofSize: 15)
    }
    let descripLabel: UILabel = UILabel().set {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
    }
    
    let buttonStackView: UIStackView = UIStackView().set {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    lazy var likeButton: UIButton = UIButton().set {
        var attrStr = NSMutableAttributedString(string: "좋아요")
        let attributes: [NSAttributedString.Key: Any] = [
              .foregroundColor: UIColor.lightGray,
              .font: UIFont.boldSystemFont(ofSize: 15)]
        attrStr.addAttributes(
          attributes,
          range: NSRange(location: 0, length: "좋아요".count))
        $0.setAttributedTitle(attrStr, for: .normal)
        
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .lightGray
      
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    lazy var commentButton: UIButton = UIButton().set {
        var attrStr = NSMutableAttributedString(string: "댓글")
        let attributes: [NSAttributedString.Key: Any] = [
              .foregroundColor: UIColor.lightGray,
              .font: UIFont.boldSystemFont(ofSize: 15)]
        attrStr.addAttributes(
          attributes,
          range: NSRange(location: 0, length: "댓글".count))
        $0.setAttributedTitle(attrStr, for: .normal)
        
        $0.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        $0.tintColor = .lightGray
      
      $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
      $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // postedAt를 UX를 위해 string으로 가공하는 func
    func studyPostedAt(at: Date) -> String {
        let currentDate = Date()
        let time = Int(currentDate.timeIntervalSince(at) / 60)
        
        if time >= 1 {
            return "\(time)분전"
        } else {
            return "방금"
        }
    }
    
}

// MARK: - LayoutSupport Protocol

extension StudyPostCell: LayoutSupport {
    func addSubviews() {
        self.addSubview(profileContainerView)
        profileContainerView.addSubview(profileImageView)
        profileContainerView.addSubview(userNameLabel)
        profileContainerView.addSubview(postedAtLabel)
        self.addSubview(postContainerView)
        postContainerView.addSubview(titleLabel)
        postContainerView.addSubview(descripLabel)
        self.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(likeButton)
        buttonStackView.addArrangedSubview(commentButton)
    }
    
    func setConstraints() {
        
        self.profileContainerView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
        }
        
        self.profileImageView.snp.makeConstraints {
            $0.top.equalTo(profileContainerView.snp.top).offset(20)
            $0.leading.equalTo(self.snp.leading).offset(24)
            $0.bottom.equalTo(profileContainerView.snp.bottom).inset(10)
            $0.height.equalTo(47).priority(999)
            $0.width.equalTo(47).priority(999)
        }
        
        self.userNameLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileContainerView.snp.top).offset(25)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(10)
        }
        
        self.postedAtLabel.snp.makeConstraints {
            $0.top.equalTo(self.userNameLabel.snp.bottom).offset(2)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(10)
        }
        
        self.postContainerView.snp.makeConstraints {
            $0.top.equalTo(self.profileContainerView.snp.bottom)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.height.equalTo(65)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.postContainerView.snp.top)
            $0.leading.equalTo(self.postContainerView.snp.leading).offset(24)
            $0.trailing.equalTo(self.postContainerView.snp.trailing).inset(24)
        }
        
        self.descripLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.postContainerView.snp.leading).offset(24)
            $0.trailing.equalTo(self.postContainerView.snp.trailing).inset(24)
        }
        
        self.buttonStackView.snp.makeConstraints {
            $0.top.equalTo(postContainerView.snp.bottom)
            $0.leading.equalTo(self.snp.leading)
            $0.trailing.equalTo(self.snp.trailing)
            $0.bottom.equalTo(self.snp.bottom)
            $0.height.equalTo(20)
        }
        
    }

}
