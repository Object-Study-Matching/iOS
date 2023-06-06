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
    let userName: UILabel = UILabel().set {
        $0.font = .boldSystemFont(ofSize: 13)
    }
    let postedAt: UILabel = UILabel().set {
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .lightGray
    }
    
    let titleContainerView = UIView()
    let mainTitle: UILabel = UILabel().set {
        $0.font = .boldSystemFont(ofSize: 15)
    }
    let subscrive: UILabel = UILabel().set {
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
          range: NSRange(location: 0, length: "좋아용".count))
        $0.setAttributedTitle(attrStr, for: .normal)
        
        $0.setImage(UIImage(systemName: "heart"), for: .normal)
        $0.tintColor = .lightGray
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
        profileContainerView.addSubview(userName)
        profileContainerView.addSubview(postedAt)
        self.addSubview(titleContainerView)
        titleContainerView.addSubview(mainTitle)
        titleContainerView.addSubview(subscrive)
        self.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(likeButton)
        buttonStackView.addArrangedSubview(commentButton)
    }
    
    func setConstraints() {
        
        self.profileContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.titleContainerView.snp.top)
            make.height.equalTo(64)
        }
        
        self.profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(24)
            make.trailing.equalTo(self.userName.snp.leading).offset(-5)
            make.centerY.equalTo(self.profileContainerView.snp.centerY)
            make.height.equalTo(44).priority(999)
            make.width.equalTo(44).priority(999)
        }
        
        self.userName.snp.makeConstraints { make in
            make.top.equalTo(self.profileContainerView.snp.top).offset(15)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(5)
            make.bottom.equalTo(self.postedAt.snp.top).offset(-3)
        }
        
        self.postedAt.snp.makeConstraints { make in
            make.top.equalTo(self.userName.snp.bottom).offset(3)
            make.leading.equalTo(self.profileImageView.snp.trailing).offset(5)
        }
        
        self.titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.profileContainerView.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.buttonStackView.snp.top)
            make.height.equalTo(85)
        }
        
        self.mainTitle.snp.makeConstraints { make in
            make.top.equalTo(self.titleContainerView.snp.top)
            make.leading.equalTo(self.titleContainerView.snp.leading).offset(24)
            make.trailing.equalTo(self.titleContainerView.snp.trailing).offset(-24)
            make.bottom.equalTo(self.subscrive.snp.top).offset(-10)
        }
        
        self.subscrive.snp.makeConstraints { make in
            make.top.equalTo(self.mainTitle.snp.bottom).offset(10)
            make.leading.equalTo(self.titleContainerView.snp.leading).offset(24)
            make.trailing.equalTo(self.titleContainerView.snp.trailing).offset(-24)
        }
        
        self.buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleContainerView.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(20)
        }
        
    }

}
