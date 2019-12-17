//
//  CommentsTableViewCell.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import PromiseKit
import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.layer.bounds.height / 2
        }
    }

    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.text = ""
            Style.shared.apply(textStyle: .smallMediumRegular(color: .primaryRed), to: titleLabel)
        }
    }

    @IBOutlet var bodyTextView: UITextView! {
        didSet {
            bodyTextView.text = ""
            Style.shared.apply(textStyle: .footnote(color: .primaryDark), to: bodyTextView)
        }
    }

    var data: Comment? {
        didSet {
            if let title = data?.name {
                titleLabel.text = title
            }
            if let body = data?.body {
                bodyTextView.text = body
            }

            loadProfileImage()
        }
    }

    private var avatarAPIWorker = AdorableAPIWorker()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadProfileImage() {
        guard let email = data?.email else {
            return
        }
        avatarAPIWorker.loadAvatarImage(with: email) { [weak self] image in
            self?.profileImage.image = image
        }
    }
}
