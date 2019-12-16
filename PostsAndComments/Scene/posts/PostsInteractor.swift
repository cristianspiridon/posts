//
//  PostsInteractor.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import PromiseKit
import UIKit

protocol PostsBusinessLogic {
    func fetchData()
}

protocol PostsDataStore {
    // var name: String { get set }
}

class PostsInteractor: PostsBusinessLogic, PostsDataStore {
    var postsAPIWorker = PostsAPIWorker()
    var commentsAPIWorker = CommentsAPIWorker()

    func fetchData() {
        firstly {
            /** fetch all posts and comments. Reason why I'm doing this is because the posts api doesn't return
             the number of comments it has, but downloading also the comments will give us the chance to make the count.

             we could have used te combine framework, or  zip rx swift, but for this small task I have choosen to use
             Promise kit, to combine multiple network requests
             */
            when(fulfilled: postsAPIWorker.loadAllPosts(), commentsAPIWorker.loadAllComments())

        }.done { posts, comments in

            /// we have both the posts and the comments,  let's persist them
            RealmService.shared.addPosts(posts)
            RealmService.shared.addComments(comments)

        }.catch { error in
            print("uh we have an error ", error)
        }
    }
}
