//
//  ChatModel.swift
//  StudyMatching
//
//  Created by SeokHyun on 2023/06/08.
//

import Foundation

struct ChatModel {
  struct LetterModel {
    var userName: String
    var recentMessage: String
    var recentDateString: String
    var profileImage: String
  }
  
  struct GroupChatModel {
    var groupName: String
    var recentDateString: String
    var profileImage: String?
    var recentMessage: String?
    var memberCount: Int
    var messageCount: Int
  }
}
extension ChatModel {
  static var letterModels: [LetterModel] = [
    .init(userName: "이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1"),
    .init(userName: "이치훈",
          recentMessage: "게시글 보고 쪽지 보냅니다. 게시글 보고 쪽지 보냅니다.",
          recentDateString: "방금 전",
          profileImage: "userProfile1")
  ]
  
  static var groupChatModels: [GroupChatModel] = [
    .init(groupName: "토익 스터디 모임 토익 스터디 모임 토익 스터디 모임 토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123),
    .init(groupName: "토익 스터디 모임",
          recentDateString: "방금 전",
          profileImage: "userProfile2",
          recentMessage: "저희 이번주 어디서 스터디 하나요? 저희 이번주 어디서 스터디 하나요?",
          memberCount: 4,
          messageCount: 123)
  ]
}
