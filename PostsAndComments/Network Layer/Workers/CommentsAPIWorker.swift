//
//  CommentsAPIWorker.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import PromiseKit
import UIKit

class CommentsAPIWorker {
    let provider = ServiceProvider<JsonplaceholderService>()

    func loadAllComments() -> Promise<[Comment]> {
        return Promise<[Comment]> { seal in

            provider.load(service: .comments(postId: .none), decodeType: [Comment].self) { result in

                switch result {
                case let .success(comments):
                    seal.fulfill(comments)
                case let .failure(error):
                    seal.reject(error)
                case .empty:
                    print("empty data")
                }
            }
        }
    }
}
