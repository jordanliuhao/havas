//
//  PostListView.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation

struct PostItem: Equatable {
    struct Image: Equatable {
        var url: String
        var width: Int
        var height: Int
    }
    
    var id: String
    var title: String
    var image: Image?
    var comments: String
    var ups: String
    
    static func empty() -> PostItem {
        return PostItem(id: "", title: "", image: nil,  comments: "", ups: "")
    }
}

struct SectionItem: Equatable {
    var title: String
}

protocol PostListView: BaseView {
    func showPostItems(_ posts: [PostItem])
}
