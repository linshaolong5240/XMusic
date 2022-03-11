//
//  CommentViewModel.swift
//  XMusic
//
//  Created by teenloong on 2022/3/12.
//  Copyright © 2022 com.teenloong. All rights reserved.
//

import Foundation
import NeteaseCloudMusicAPI

class CommentViewModel: ObservableObject, Identifiable {
    var beReplied = [CommentViewModel]()
    var commentId: Int = 0
    var content: String = ""
    var id: Int = 0 // commentId for Identifiable
    @Published var liked: Bool = false
    var likedCount: Int = 0
    var parentCommentId: Int = 0
    var userId: Int = 0
    var avatarUrl: String = ""
    var nickname: String = ""
    
    init() {
        
    }
    
    init(_ comment: NCMCommentSongResponse.Comment) {
        self.beReplied = comment.beReplied.map{CommentViewModel($0)}
        self.commentId = comment.commentId
        self.content = comment.content
        self.id = comment.commentId
        self.liked = comment.liked
        self.likedCount = comment.likedCount
        self.parentCommentId = comment.parentCommentId
        self.userId = comment.user.userId
        self.avatarUrl = comment.user.avatarUrl
        self.nickname = comment.user.nickname
    }
    
    init(_ comment: NCMCommentSongResponse.Comment.BeReplied) {
        self.commentId = comment.beRepliedCommentId
        self.content = comment.content ?? ""
        self.id = comment.user.userId
        self.avatarUrl = comment.user.avatarUrl
        self.nickname = comment.user.nickname
    }}
