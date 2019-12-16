//
//  CommentsRouter.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import UIKit

@objc protocol CommentsRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CommentsDataPassing {
    var dataStore: CommentsDataStore? { get }
}

class CommentsRouter: NSObject, CommentsRoutingLogic, CommentsDataPassing {
    weak var viewController: CommentsViewController?
    var dataStore: CommentsDataStore?

    // MARK: Routing

    // func routeToSomewhere(segue: UIStoryboardSegue?)
    // {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    // }

    // MARK: Navigation

    // func navigateToSomewhere(source: CommentsViewController, destination: SomewhereViewController)
    // {
    //  source.show(destination, sender: nil)
    // }

    // MARK: Passing data

    // func passDataToSomewhere(source: CommentsDataStore, destination: inout SomewhereDataStore)
    // {
    //  destination.name = source.name
    // }
}
