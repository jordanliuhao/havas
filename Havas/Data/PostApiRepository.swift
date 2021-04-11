//
//  PostApiRepository.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation
import RxSwift

class PostApiRepository: PostRepository {
    func load() -> Single<[Post]> {
        let request = URLRequest(url: URL(string: "https://www.reddit.com/.json")!)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw ApiError.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let posts = try JSONDecoder().decode(PostListing.self, from: data)
                    return PostMapping.postListingToPosts(posts)
                } catch let error {
                    throw ApiError.invalidJSON(error)
                }
            }.asSingle()
    }
}
