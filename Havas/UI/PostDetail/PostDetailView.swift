//
//  PostListView.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation

@objc class PostDetail: NSObject {
    @objc class Image: NSObject {
        @objc var url: String
        @objc var width: Int
        @objc var height: Int
        
        init(url: String, width: Int, height: Int) {
            self.url = url
            self.width = width
            self.height = height
        }
    }
    
    @objc var id: String
    @objc var title: String
    @objc var image: Image?
    @objc var body: String?
    @objc var comments: String
    @objc var ups: String
    
    init(id: String, title: String, image: Image?, body: String?, comments: String, ups: String) {
        self.id = id
        self.title = title
        self.image = image
        self.body = body
        self.comments = comments
        self.ups = ups
    }
    
    static func empty() -> PostDetail {
        return PostDetail(id: "", title: "", image: nil, body: "", comments: "", ups: "")
    }
}

@objc protocol PostDetailView: NSObjectProtocol {
    func showPostDetail(_ post: PostDetail)
}
