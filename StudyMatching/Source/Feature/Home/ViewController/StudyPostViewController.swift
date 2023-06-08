//
//  HomeViewController.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/04.
//

import SnapKit
import UIKit

class StudyPostViewController: UIViewController {
  
  // MARK: - Properties
  
  let searchTextFieldView = UIView().set {
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 25
    $0.layer.borderColor = UIColor.black.cgColor
    $0.layer.borderWidth = 2.0
  }
  let searchOptionView = UIView().set {
    $0.backgroundColor = .systemGroupedBackground
  }
  
  let searchTextField = UITextField().set {
    $0.borderStyle = .none
    $0.placeholder = " 키워드를 검색하세요."
  }
  
  let searchImageView = UIImageView().set {
    let image = UIImage(named: "search")
    $0.image = image
  }
  
  lazy var addStudyGroupButton = UIButton().set {
    $0.setImage(UIImage(named: "addGroupButton"), for: .normal)
    $0.addTarget(self, action: #selector(showGroupSettingPage), for: .touchUpInside)
  }
  
  // 서버에서 개발이 아직 안됐기 때문에 정적 model로 대체함
  var studyMatchingPost = [
    StudyPostModel(profileImage: UIImage(named: "userProfile1"),
                   userName: "양승현",
                   mainTitle: "대전대에서 swift 스터디 하실분 구해요!",
                   descrip: "맥북만 있으면 모두 참가하실 수 있습니다.",
                   likeCount: 2,
                   commentCount: 2),
    StudyPostModel(profileImage: UIImage(named: "userProfile1"),
                   userName: "김석현",
                   mainTitle: "일렉기타 함께 배우실분??",
                   descrip: "함께 연주해봐요!",
                   likeCount: 5,
                   commentCount: 2),
    StudyPostModel(profileImage: UIImage(named: "userProfile2"),
                   userName: "이치훈",
                   mainTitle: "함께 공모전 참가할 팀원 구해요",
                   descrip: "K-해커톤, 함께할 디자이너, 백엔드 개발자 모십니다.",
                   likeCount: 3,
                   commentCount: 2)
  ]
  let studyPostTableView = UITableView()
  
  // let locationSelector = UIButton()
  
  // 버튼추가TODO: 이 기능은 다른 버튼으로 대체될 수 있음 (ex: 우측상단 슬라이드 버튼)
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    searchTextField.delegate = self
    studyPostTableView.delegate = self
    studyPostTableView.dataSource = self
    setupUI()
    
    studyPostTableView.separatorStyle = .none
    
    self.view.backgroundColor = .white
    studyPostTableView.register(StudyPostCell.self,
                                forCellReuseIdentifier: "StudyMatchingPostCell")
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = true
  }
  
}

// MARK: - Action Logic

extension StudyPostViewController {
  
  @objc func showGroupSettingPage() {
    
    print("push showGroupSettingPage")
    
    // present기능추가TODO: showGroupSettingPage
    
  }
  
}

// MARK: - UITableViewProtocol

extension StudyPostViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return studyMatchingPost.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "StudyMatchingPostCell", for: indexPath)
        as? StudyPostCell {
      
      cell.profileImageView.image = studyMatchingPost[indexPath.row].profileImage
      cell.userNameLabel.text = studyMatchingPost[indexPath.row].userName
      cell.postedAtLabel.text = "방금"
      
      cell.titleLabel.text = studyMatchingPost[indexPath.row].mainTitle
      cell.descripLabel.text = studyMatchingPost[indexPath.row].descrip
      
      return cell
    } else {
      return StudyPostCell(style: .default, reuseIdentifier: "StudyMatchingPostCell")
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    self.navigationController?.pushViewController(StudyFeedViewController(
      studyPostModel: studyMatchingPost[indexPath.row]), animated: true)
  }
  
}

// MARK: - UITextFieldProtocol

extension StudyPostViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.text = (textField.text ?? "").trimmingCharacters(in: .whitespaces)
    searchTextField.resignFirstResponder()
    print(textField.text ?? "")
    return true
  }
  
}

// MARK: LayoutSupport Protocol

extension StudyPostViewController: LayoutSupport {
  
  func addSubviews() {
    self.view.addSubview(searchTextFieldView)
    searchTextFieldView.addSubview(searchImageView)
    searchTextFieldView.addSubview(searchTextField)
    self.view.addSubview(addStudyGroupButton)
    self.view.addSubview(searchOptionView)
    self.view.addSubview(studyPostTableView)
    
    // 버튼addSubView추가TODO: searchOptionView에 지역 옵션을 설정하는 버튼을 추가
    
  }
  
  func setConstraints() {
    
    self.searchTextFieldView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(25)
      $0.trailing.equalTo(self.addStudyGroupButton.snp.leading).offset(-21) // **
      
      $0.height.equalTo(50)
    }
    
    self.searchImageView.snp.makeConstraints {
      $0.leading.equalTo(self.searchTextFieldView.snp.leading).offset(16)
      $0.trailing.equalTo(self.searchTextField.snp.leading).offset(-3)
      $0.centerY.equalTo(self.searchTextFieldView.snp.centerY)
      $0.height.equalTo(15).priority(UILayoutPriority(900))
      $0.width.equalTo(15).priority(UILayoutPriority(900))
    }
    
    self.searchTextField.snp.makeConstraints {
      $0.top.equalTo(self.searchTextFieldView.snp.top).offset(3)
      $0.leading.equalTo(self.searchImageView.snp.trailing).offset(3)
      $0.trailing.equalTo(self.searchTextFieldView.snp.trailing).offset(-16)
      $0.bottom.equalTo(self.searchTextFieldView.snp.bottom).offset(-3)
    }
    
    self.addStudyGroupButton.snp.makeConstraints {
      $0.leading.equalTo(self.searchTextFieldView.snp.trailing).offset(21) // **
      
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-25)
      $0.centerY.equalTo(self.searchTextFieldView)
      $0.height.equalTo(34)
      $0.width.equalTo(34)
    }
    
    self.searchOptionView.snp.makeConstraints {
      $0.top.equalTo(self.searchTextFieldView.snp.bottom)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
      $0.bottom.equalTo(self.studyPostTableView.snp.top)
      $0.height.equalTo(self.searchTextFieldView.snp.height)
    }
    
    self.studyPostTableView.snp.makeConstraints {
      $0.top.equalTo(searchOptionView.snp.bottom)
      $0.leading.equalTo(self.view.snp.leading)
      $0.trailing.equalTo(self.view.snp.trailing)
      $0.bottom.equalTo(self.view.snp.bottom).offset(-95)
    }
    
  }
  
}
