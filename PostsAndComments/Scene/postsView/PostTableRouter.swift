//
//  PostTableRouter.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import UIKit

@objc protocol PostTableRoutingLogic {
    func routeToComments()
}

protocol PostTableDataPassing {
    var dataStore: PostTableDataStore? { get set }
}

class PostTableRouter: NSObject, PostTableRoutingLogic, PostTableDataPassing {
    weak var viewController: PostTableViewController?
    var dataStore: PostTableDataStore?

    // MARK: Routing

    func routeToComments() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "Comments") as! CommentsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToComments(source: dataStore!, destination: &destinationDS)
        navigateToComments(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToComments(source: PostTableViewController, destination: CommentsViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToComments(source: PostTableDataStore, destination: inout CommentsDataStore) {
        destination.selectedPost = source.selectedPost
    }
}
