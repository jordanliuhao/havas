//
//  Post.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import Foundation

struct PostListing: Codable, Equatable {
    struct PostsData: Codable, Equatable {
        struct PostT3: Codable, Equatable {
            struct PostData: Codable, Equatable {
                struct Preview: Codable, Equatable {
                    struct Image: Codable, Equatable {
                        struct Source: Codable, Equatable {
                            var url: String
                            var width: Int
                            var height: Int
                        }
                        var source: Source
                    }
                    var images: [Image]
                }
                
                var id: String
                var title: String
                var preview: Preview?
                var comments: Int
                var ups: Int
                var selftext: String?
                
                enum CodingKeys: String, CodingKey {
                    case id
                    case title
                    case preview
                    case comments = "num_comments"
                    case ups
                    case selftext
                }
            }
            
            var data: PostData
        }
        
        var dist: Int
        var children: [PostT3]
    }
    
    var data: PostsData
}

struct Post {
    struct Image: Codable, Equatable {
        var url: String
        var width: Int
        var height: Int
    }
    
    var id: String
    var title: String
    var image: Image?
    var comments: Int
    var ups: Int
    var selftext: String?
}

struct PostMapping {
    static func postListingToPosts(_ postListing: PostListing) -> [Post] {
        return postListing.data.children.map { postT3 in
            return postDataToPost(postT3.data)
        }
    }
    
    static func postDataToPost(_ data: PostListing.PostsData.PostT3.PostData) -> Post {
        return Post(
            id: data.id,
            title: data.title,
            image: sourceToImage(data.preview?.images[0].source),
            comments: data.comments,
            ups: data.ups,
            selftext: data.selftext)
    }
    
    static func sourceToImage(_ source: PostListing.PostsData.PostT3.PostData.Preview.Image.Source?) -> Post.Image? {
        guard let src = source else {
            return nil
        }
        return Post.Image(
            url: src.url.replacingOccurrences(of: "&amp;", with: "&"),
            width: src.width,
            height: src.height)
    }
}
