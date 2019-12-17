//
//  CommentsRouter.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import UIKit

@objc protocol CommentsRoutingLogic {}

protocol CommentsDataPassing {
    var dataStore: CommentsDataStore? { get }
}

class CommentsRouter: NSObject, CommentsRoutingLogic, CommentsDataPassing {
    weak var viewController: CommentsViewController?
    var dataStore: CommentsDataStore?

    // MARK: Routing

    // MARK: Navigation

    // MARK: Passing data
}
