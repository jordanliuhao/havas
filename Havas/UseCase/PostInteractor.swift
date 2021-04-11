//
//  PostInteractor.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation
import RxSwift

class PostInteractor: BaseInteractor {
    private let postRepository: PostRepository
    private let disposeBag = DisposeBag()
    
    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }
    
    // It could be returning Single<[Post]>, just want to emphasize the separation of command/query pattern
    func load() -> Single<Void> {
        return postRepository.load()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { posts in
                Store.shared.postsState.onNext(posts)
            })
            .map { _ in Void() }
    }
    
    func selectCurrentPost(_ post: Post?) {
        Store.shared.currentPostState.onNext(post)
    }
}
