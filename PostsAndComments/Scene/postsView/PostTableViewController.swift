//
//  PostTableViewController.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import UIKit

protocol PostTableDisplayLogic: class {
    var tableViewReference: UITableView { get }
    func reloadTableView()
}

class PostTableViewController: UITableViewController, PostTableDisplayLogic {
    var tableViewReference: UITableView {
        return tableView
    }

    var interactor: PostTableBusinessLogic?
    var router: (NSObjectProtocol & PostTableRoutingLogic & PostTableDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = PostTableInteractor()
        let router = PostTableRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        interactor?.fetchAllData()
    }

    func reloadTableView() {
        tableView.reloadData()
    }
}

extension PostTableViewController {
    // MARK: - Table view data source and delegates

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let interactor = interactor else {
            return 0
        }
        return interactor.numberOfRowsInSection
    }

    override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: PostsTableViewCell = interactor?.cellFor(indexPath) {
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let postObject = interactor?.dataFor(indexPath) {
            router?.dataStore?.selectedPost = postObject
            router?.routeToComments()
        }
    }
}
