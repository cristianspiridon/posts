//
//  CommentsInteractor.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import UIKit

protocol CommentsBusinessLogic {
    var numberOfRowsInSection: Int { get }
    func fetchHeaderData()
    func cellFor(_ indexPath: IndexPath) -> CommentsTableViewCell?
    func dataFor(_ indexPath: IndexPath) -> Comment?
}

protocol CommentsDataStore {
    var selectedPost: Post? { get set }
}

class CommentsInteractor: CommentsBusinessLogic, CommentsDataStore {
    var selectedPost: Post? {
        didSet {
            if let post = selectedPost {
                comments = RealmService.shared.getAllComments(by: post.id)
            }
        }
    }

    weak var viewController: CommentsDisplayLogic?
    var worker: CommentsWorker?
    private var comments = [Comment]()

    var numberOfRowsInSection: Int {
        return comments.count
    }

    // MARK: Do something

    func fetchHeaderData() {
        guard let post = selectedPost else {
            return
        }
        let data = Comments.Data.ViewModel(title: post.title, body: post.body)
        viewController?.displayInfo(viewModel: data)
    }

    func dataFor(_ indexPath: IndexPath) -> Comment? {
        // check index out of bounds
        if comments.indices.contains(indexPath.row) == false {
            return nil
        }
        return comments[indexPath.row]
    }

    func cellFor(_ indexPath: IndexPath) -> CommentsTableViewCell? {
        guard let cell = viewController?.tableViewReference.dequeueReusableCell(withIdentifier: "CommentCell") as? CommentsTableViewCell,
            let data = dataFor(indexPath) else {
            return nil
        }
        cell.data = data
        return cell
    }
}
