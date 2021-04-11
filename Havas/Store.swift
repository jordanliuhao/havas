//
//  Store.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation
import RxSwift

class Store {
    static let shared = Store()
    
    let postInteractor = PostInteractor(postRepository: PostApiRepository())
    
    let postsState = BehaviorSubject<[Post]>(value: [])
    let currentPostState = BehaviorSubject<Post?>(value: nil)
}
