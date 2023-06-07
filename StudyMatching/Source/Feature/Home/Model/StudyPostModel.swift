//
//  StudyMatchingPostModel.swift
//  StudyMatching
//
//  Created by 이치훈 on 2023/06/06.
//

import UIKit

struct StudyPostModel {
    
    var profileImage = UIImage(systemName: "person.crop.circle")
    var userName = "UserName"
    var postedAt = Date()
    var mainTitle = "Title"
    var subscrive = "description"
    
    var likeCount = 0
    var commentCount = 0
    
}
