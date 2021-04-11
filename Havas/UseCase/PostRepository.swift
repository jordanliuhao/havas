//
//  PostRepository.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation
import RxSwift

enum ApiError: Swift.Error {
    case invalidResponse(URLResponse?)
    case invalidJSON(Swift.Error)
}

protocol PostRepository {
    func load() -> Single<[Post]>
}
