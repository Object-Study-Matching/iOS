//
//  HomeViewController.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/04.
//

import SnapKit
import UIKit

class HomeViewController: UITableViewController {
    
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
    
    var studyMatchingPost = [
        StudyMatchingPostModel(profileImage: UIImage(named: "2fb3451f2790627112ebba6732cb7a49"),
                               userName: "양승현",
                               mainTitle: "대전대에서 swift 스터디 하실분 구해요!",
                               subscrive: "맥북만 있으면 모두 참가하실 수 있습니다."),
        StudyMatchingPostModel(profileImage: UIImage(named: "2fb3451f2790627112ebba6732cb7a49"),
                               userName: "김석현",
                               mainTitle: "일렉기타 함께 배우실분??",
                               subscrive: "함께 연주해봐요!"),
        StudyMatchingPostModel(profileImage: UIImage(named: "2e88faead86a9f0d3bc1009b2a11bff5"),
                               userName: "이치훈",
                               mainTitle: "함께 공모전 참가할 팀원 구해요",
                               subscrive: "K-해커톤, 함께할 디자이너, 백엔드 개발자 모십니다.")
    ]
    
    // let locationSelector = UIButton()
    
    // 버튼추가TODO: 이 기능은 다른 버튼으로 대체될 수 있음 (ex: 우측상단 슬라이드 버튼)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchTextField.delegate = self
        setupUI()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.register(StudyMatchingPostCell.self, forCellReuseIdentifier: "StudyMatchingPostCell")
        self.tableView.reloadData()
    }
    
}

// MARK: - Action Logic

extension HomeViewController {
 
    @objc func showGroupSettingPage() {
        
        print("push showGroupSettingPage")
        
        // present기능추가TODO: showGroupSettingPage
        
    }
    
}

// MARK: - UITableViewLogic

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyMatchingPost.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StudyMatchingPostCell", for: indexPath)
            as? StudyMatchingPostCell {
            
            cell.profileImageView.image = studyMatchingPost[indexPath.row].profileImage
            cell.userName.text = studyMatchingPost[indexPath.row].userName
            cell.postedAt.text = "방금"
            
            cell.mainTitle.text = studyMatchingPost[indexPath.row].mainTitle
            cell.subscrive.text = studyMatchingPost[indexPath.row].subscrive
            
            return cell
        } else {
            return StudyMatchingPostCell(style: .default, reuseIdentifier: "StudyMatchingPostCell")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // navigationPopTODO: - Group 모집 페이지로 이동
        
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.text = (textField.text ?? "").trimmingCharacters(in: .whitespaces)
        searchTextField.resignFirstResponder()
        print(textField.text ?? "")
        return true
    }
    
}

// MARK: LayoutSupport Protocol

extension HomeViewController: LayoutSupport {
        
    func addSubviews() {
        self.view.addSubview(searchTextFieldView)
        searchTextFieldView.addSubview(searchImageView)
        searchTextFieldView.addSubview(searchTextField)
        self.view.addSubview(addStudyGroupButton)
        self.view.addSubview(searchOptionView)
        
        // 버튼addSubView추가TODO: searchOptionView에 지역 옵션을 설정하는 버튼을 추가
        
    }
    
    func setConstraints() {
        
        self.searchTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        self.searchTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(25)
            make.trailing.equalTo(self.addStudyGroupButton.snp.leading).offset(-21)
            make.height.equalTo(50)
        }
        
        self.searchImageView.translatesAutoresizingMaskIntoConstraints = false
        self.searchImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.searchTextFieldView.snp.leading).offset(16)
            make.trailing.equalTo(self.searchTextField.snp.leading).offset(-3)
            make.centerY.equalTo(self.searchTextFieldView.snp.centerY)
            make.height.equalTo(15).priority(UILayoutPriority(900))
            make.width.equalTo(15).priority(UILayoutPriority(900))
        }
        
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.searchTextFieldView.snp.top).offset(3)
            make.leading.equalTo(self.searchImageView.snp.trailing).offset(3)
            make.trailing.equalTo(self.searchTextFieldView.snp.trailing).offset(-16)
            make.bottom.equalTo(self.searchTextFieldView.snp.bottom).offset(-3)
        }
        
        self.addStudyGroupButton.translatesAutoresizingMaskIntoConstraints = false
        self.addStudyGroupButton.snp.makeConstraints { make in
            make.leading.equalTo(self.searchTextFieldView.snp.trailing).offset(21)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-25)
            make.centerY.equalTo(self.searchTextFieldView)
            make.height.equalTo(34)
            make.width.equalTo(34)
        }
        
        self.searchOptionView.translatesAutoresizingMaskIntoConstraints = false
        self.searchOptionView.snp.makeConstraints { make in
            make.top.equalTo(self.searchTextFieldView.snp.bottom)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self.searchTextFieldView.snp.height)
        }
        
    }
    
}
