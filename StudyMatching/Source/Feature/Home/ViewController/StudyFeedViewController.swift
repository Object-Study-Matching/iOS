//
//  StudyFeedViewController.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/07.
//

import SceneKit
import UIKit

class StudyFeedViewController: UIViewController {
  
  // MARK: - Properties
  
  let feedView = UIView()
  let profileContainerView = UIView()
  let userProfileImageView: UIImageView = UIImageView().set {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 23
  }
  let userNameLabel: UILabel = UILabel().set {
    $0.font = .boldSystemFont(ofSize: 13)
  }
  let postedAtLabel: UILabel = UILabel().set {
    $0.font = .systemFont(ofSize: 10)
    $0.textColor = .lightGray
  }
  let ETCButton: UIButton = UIButton().set {
    $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    $0.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
    $0.imageView?.tintColor = .black
  }
  
  let postContainerView = UIView()
  let titleLable: UILabel = UILabel().set {
    $0.font = .boldSystemFont(ofSize: 17)
  }
  let descripLabel: UILabel = UILabel().set {
    $0.font = .systemFont(ofSize: 13)
    $0.textColor = .label
    $0.numberOfLines = 0
  }
  
  let interactionStackView: UIStackView = UIStackView().set {
    $0.axis = .horizontal
    $0.alignment = .fill
    $0.distribution = .equalSpacing
    $0.spacing = 15
  }
  let likeButton: UIButton = UIButton().set {
    $0.setImage(UIImage(systemName: "heart"), for: .normal)
    $0.tintColor = .lightGray
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
  }
  let commentButton: UIButton = UIButton().set {
    $0.setImage(UIImage(systemName: "bubble.left"), for: .normal)
    $0.tintColor = .lightGray
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
    $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
  }
  
  let commentTableView = UITableView()
  
  var studyPostModel: StudyPostModel
  
  var comments = [
    CommentModel(profileImage: UIImage(named: "userProfile1"),
                 userName: "홍길동",
                 comment: "안녕하세요, 스터디 자리 남았나요??"),
    CommentModel(profileImage: UIImage(named: "userProfile2"),
                 userName: "스티븐잡스",
                 comment: "함께 해요!")
  ]
  
  // MARK: - LifeCycle
  
  init(studyPostModel: StudyPostModel) {
    self.studyPostModel = studyPostModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.commentTableView.delegate = self
    self.commentTableView.dataSource = self
    
    setNavigationBar()
    self.view.backgroundColor = .white
    setupUI()
    setpostValue()
    
    commentTableView.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
  }
  
  func setNavigationBar() {
    self.navigationController?.isNavigationBarHidden = false
    self.navigationItem.title = studyPostModel.mainTitle
    let naviItem = UIButton()
    naviItem.setImage(UIImage(named: "chevron.left"), for: .normal)
    naviItem.tintColor = .black
    naviItem.addTarget(self, action: #selector(popNavigation), for: .touchUpInside)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: naviItem)
  }
  
  func setpostValue() {
    userProfileImageView.image = studyPostModel.profileImage
    userNameLabel.text = studyPostModel.userName
    postedAtLabel.text = studyPostModel.postedAt
    titleLable.text = studyPostModel.mainTitle
    descripLabel.text = studyPostModel.descrip
    likeButton.setTitle("\(studyPostModel.likeCount)", for: .normal)
    commentButton.setTitle("\(studyPostModel.commentCount)", for: .normal)
    
    let likeAttrStr = NSMutableAttributedString(string: "\(studyPostModel.likeCount)")
    let likeAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.lightGray,
      .font: UIFont.boldSystemFont(ofSize: 15)]
    likeAttrStr.addAttributes(
      likeAttributes,
      range: NSRange(location: 0, length: "\(studyPostModel.likeCount)".count))
    likeButton.setAttributedTitle(likeAttrStr, for: .normal)
    
    likeButton.setTitle("\(studyPostModel.likeCount)", for: .normal)
    let commentAttrStr = NSMutableAttributedString(string: "\(studyPostModel.commentCount)")
    let commentAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.lightGray,
      .font: UIFont.boldSystemFont(ofSize: 15)]
    commentAttrStr.addAttributes(
      commentAttributes,
      range: NSRange(location: 0, length: "\(studyPostModel.commentCount)".count))
    commentButton.setAttributedTitle(commentAttrStr, for: .normal)
    
  }
  
}

// MARK: - UITableViewProtocol

extension StudyFeedViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        as? CommentCell {
      
      cell.userProfileImageView.image = comments[indexPath.row].profileImage
      cell.userNameLabel.text = comments[indexPath.row].userName
      cell.commentLabel.text = comments[indexPath.row].comment
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "M/dd HH:mm"
      cell.dateLabel.text = dateFormatter.string(for: comments[indexPath.row].postedDate)
      
      return cell
    } else {
      return CommentCell(style: .default, reuseIdentifier: "CommentCell")
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

// MARK: - Action

extension StudyFeedViewController {
  
  @objc func popNavigation() {
    self.navigationController?.popViewController(animated: true)
  }
  
}

// MARK: - LayoutSupport

extension StudyFeedViewController: LayoutSupport {
  
  func addSubviews() {
    self.view.addSubview(feedView)
    self.feedView.addSubview(profileContainerView)
    profileContainerView.addSubview(userProfileImageView)
    profileContainerView.addSubview(userNameLabel)
    profileContainerView.addSubview(postedAtLabel)
    profileContainerView.addSubview(ETCButton)
    
    self.feedView.addSubview(postContainerView)
    postContainerView.addSubview(titleLable)
    postContainerView.addSubview(descripLabel)
    
    self.feedView.addSubview(interactionStackView)
    interactionStackView.addArrangedSubview(likeButton)
    interactionStackView.addArrangedSubview(commentButton)
    
    self.view.addSubview(commentTableView)
  }
  
  func setConstraints() {
    
    self.feedView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide)
      $0.bottom.equalTo(commentTableView.snp.top)
    }
    
    setProfileContainerConstraint()
    setPostContainerViewConstraint()
    setInteractionStackViewConstraint()
    
  }
  
  // ------------------------------------------------------------------------
  
  func setProfileContainerConstraint() {
    self.profileContainerView.snp.makeConstraints {
      $0.top.equalTo(feedView.snp.top)
      $0.leading.equalTo(feedView.snp.leading)
      $0.trailing.equalTo(feedView.snp.trailing)
    }
    
    self.userProfileImageView.snp.makeConstraints {
      $0.top.equalTo(profileContainerView.snp.top).offset(10)
      $0.leading.equalTo(profileContainerView.snp.leading).offset(24)
      $0.bottom.equalTo(profileContainerView.snp.bottom).inset(10)
      $0.height.equalTo(47).priority(999)
      $0.width.equalTo(47).priority(999)
    }
    
    self.userNameLabel.snp.makeConstraints {
      $0.top.equalTo(profileContainerView.snp.top).offset(15)
      $0.leading.equalTo(userProfileImageView.snp.trailing).offset(10)
    }
    
    self.postedAtLabel.snp.makeConstraints {
      $0.top.equalTo(userNameLabel.snp.bottom).offset(2)
      $0.leading.equalTo(userProfileImageView.snp.trailing).offset(10)
    }
    
    self.ETCButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(17)
      $0.trailing.equalToSuperview().inset(20)
    }
  }
  
  func setPostContainerViewConstraint() {
    self.postContainerView.snp.makeConstraints {
      $0.top.equalTo(profileContainerView.snp.bottom)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide)
    }
    
    self.titleLable.snp.makeConstraints {
      $0.top.equalTo(postContainerView.snp.top)
      $0.leading.equalTo(postContainerView.snp.leading).offset(24)
      $0.trailing.equalTo(postContainerView.snp.trailing).inset(24)
    }
    
    self.descripLabel.snp.makeConstraints {
      $0.top.equalTo(titleLable.snp.bottom).offset(8)
      $0.leading.equalTo(postContainerView.snp.leading).offset(24)
      $0.trailing.equalTo(postContainerView.snp.trailing).inset(24)
      $0.bottom.equalTo(postContainerView.snp.bottom)
      $0.height.equalTo(75)
    }
  }
  
  func setInteractionStackViewConstraint() {
    self.interactionStackView.snp.makeConstraints {
      $0.top.equalTo(postContainerView.snp.bottom).offset(3)
      $0.leading.equalTo(feedView.snp.leading).offset(24)
      $0.bottom.equalTo(feedView.snp.bottom).inset(3)
    }
    
    self.commentTableView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().inset(95)
    }
  }
  
}
