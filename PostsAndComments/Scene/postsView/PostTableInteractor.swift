//
//  PostTableInteractor.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import PromiseKit
import UIKit

protocol PostTableBusinessLogic {
    var numberOfRowsInSection: Int { get }
    func fetchAllData()
    func cellFor(_ indexPath: IndexPath) -> PostsTableViewCell?
    func dataFor(_ indexPath: IndexPath) -> Post?
}

protocol PostTableDataStore {
    var selectedPost: Post? { get set }
}

class PostTableInteractor: PostTableBusinessLogic, PostTableDataStore {
    weak var viewController: PostTableDisplayLogic?

    private var postsAPI = PostsAPIWorker()
    private var commentsAPI = CommentsAPIWorker()
    private var posts = [Post]()

    var selectedPost: Post?
    var numberOfRowsInSection: Int {
        posts = RealmService.shared.getAllPosts()
        return posts.count
    }

    func fetchAllData() {
        firstly {
            when(fulfilled: postsAPI.loadAllPosts(), commentsAPI.loadAllComments())
        }.done { [weak self] posts, comments in
            RealmService.shared.addPosts(posts)
            RealmService.shared.addComments(comments)
            self?.viewController?.reloadTableView()
        }.catch { error in
            print(error)
        }
    }

    func dataFor(_ indexPath: IndexPath) -> Post? {
        // check index out of bounds
        if posts.indices.contains(indexPath.row) == false {
            return nil
        }
        return posts[indexPath.row]
    }

    func cellFor(_ indexPath: IndexPath) -> PostsTableViewCell? {
        guard let cell = viewController?.tableViewReference.dequeueReusableCell(withIdentifier: "PostCell") as? PostsTableViewCell,
            let data = dataFor(indexPath) else {
            return nil
        }
        cell.data = data
        return cell
    }
}
