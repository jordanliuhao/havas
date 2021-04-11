//
//  PostDetailPresenter.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation
import RxSwift
import RxCocoa

@objc class PostDetailPresenter: BasePresenter {
    private weak var view: PostDetailView?
    private weak var router: PostDetailRouter?
    
    private let disposeBag = DisposeBag()
    
    @objc init(view: PostDetailView, router: PostDetailRouter) {
        self.view = view
        self.router = router
    }
    
    @objc func bindView() {
        Store.shared.currentPostState
            .asDriver(onErrorJustReturn: nil)
            .asObservable()
            .subscribe(onNext: { [weak self] post in
                if let current = post, let detail = self?.mapModelToView(post: current) {
                    self?.view?.showPostDetail(detail)
                }
            }).disposed(by: disposeBag)
    }

    func mapModelToView(post: Post) -> PostDetail {
        return PostDetail(
            id: post.id,
            title: post.title,
            image: post.image == nil ? nil : mapModelToView(image: post.image!),
            body: post.selftext,
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
    
    func mapModelToView(image: Post.Image) -> PostDetail.Image {
        return PostDetail.Image(
            url: image.url,
            width: image.width,
            height: image.height)
    }
}
