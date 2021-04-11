//
//  PostListPresenter.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation
import RxSwift
import RxCocoa

class PostListPresenter: BasePresenter {
    private weak var view: PostListView?
    private weak var router: PostListRouter?
    
    private let disposeBag = DisposeBag()
    
    init(view: PostListView, router: PostListRouter?) {
        self.view = view
        self.router = router
    }
    
    func bindView() {
        bindPostList()
    }
    
    func onStart() {
        Store.shared.postInteractor.load()
            .subscribe(onSuccess: { (_) in
                
            }, onFailure: { [weak self] error in
                self?.view?.showError(error)
            }).disposed(by: disposeBag)
    }
    
    func onPostItemSelected(_ item: PostItem) {
        let posts = try? Store.shared.postsState.value()
        posts?.forEach({ post in
            if post.id == item.id {
                Store.shared.postInteractor.selectCurrentPost(post)
                router?.showPostDetail()
            }
        })
    }
    
    func bindPostList() {
        Store.shared.postsState
            .asDriver(onErrorJustReturn: [])
            .asObservable()
            .subscribe(onNext: { [weak self] posts in
                if let items = self?.mapModelToView(posts: posts) {
                    self?.view?.showPostItems(items)
                }
            }).disposed(by: disposeBag)
    }
    
    func mapModelToView(posts: [Post]) -> [PostItem] {
        return posts.map { post in
            return mapModelToView(post: post)
        }
    }
    
    func mapModelToView(post: Post) -> PostItem {
        return PostItem(
            id: post.id,
            title: post.title,
            image: post.image == nil ? nil : mapModelToView(image: post.image!),
            comments: String.localizedStringWithFormat(NSLocalizedString("%d Comments", comment: ""), post.comments),
            ups: mapModelToView(ups: post.ups))
    }
    
    func mapModelToView(ups: Int) -> String {
        if (ups > 1000) {
            return "" + String(ups / 1000) + "K"
        } else {
            return String(ups)
        }
    }
    
    func mapModelToView(image: Post.Image) -> PostItem.Image {
        return PostItem.Image(
            url: image.url,
            width: image.width,
            height: image.height)
    }
}
