//
//  CommentsViewController.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright (c) 2019 cs. All rights reserved.
//

import UIKit

protocol CommentsDisplayLogic: class {
    var tableViewReference: UITableView { get }
    func displayInfo(viewModel: Comments.Data.ViewModel)
}

class CommentsViewController: UIViewController, CommentsDisplayLogic {
    var interactor: CommentsBusinessLogic?
    var router: (NSObjectProtocol & CommentsRoutingLogic & CommentsDataPassing)?

    @IBOutlet var tableView: UITableView!
    var tableViewReference: UITableView {
        return tableView
    }

    @IBOutlet var titleLabel: UILabel! {
        didSet {
            Style.shared.apply(textStyle: .title(color: .primaryDark), to: titleLabel)
        }
    }

    @IBOutlet var bodyTextView: UITextView! {
        didSet {
            Style.shared.apply(textStyle: .body(color: .primaryDark), to: bodyTextView)
        }
    }

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
        let interactor = CommentsInteractor()
        let router = CommentsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Do something

    func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        interactor?.fetchHeaderData()
    }

    func displayInfo(viewModel: Comments.Data.ViewModel) {
        titleLabel.text = viewModel.title
        bodyTextView.text = viewModel.body
    }
}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source and delegates

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let interactor = interactor else {
            return 0
        }
        return interactor.numberOfRowsInSection
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CommentsTableViewCell = interactor?.cellFor(indexPath) {
            return cell
        }
        return UITableViewCell()
    }
}
