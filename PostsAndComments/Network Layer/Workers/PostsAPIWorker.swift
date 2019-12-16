//
//  PostsAPIWorker.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import Foundation
import PromiseKit

class PostsAPIWorker {
    let provider = ServiceProvider<JsonplaceholderService>()

    func loadAllPosts() -> Promise<[Post]> {
        return Promise<[Post]> { seal in
            provider.load(service: .posts, decodeType: [Post].self) { result in
                switch result {
                case let .success(posts):
                    seal.fulfill(posts)
                case let .failure(error):
                    seal.reject(error)
                case .empty:
                    print("empty data")
                }
            }
        }
    }
}
