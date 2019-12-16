//
//  PostsTableViewCell.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet var title: UILabel! {
        didSet {
            title.text = ""
            Style.shared.apply(textStyle: .title(color: .primaryDark), to: title)
        }
    }

    @IBOutlet var bodyComment: UITextView! {
        didSet {
            bodyComment.text = ""
            Style.shared.apply(textStyle: .body(color: .primaryDark), to: bodyComment)
        }
    }

    @IBOutlet var numberOfComments: UILabel! {
        didSet {
            numberOfComments.text = ""
            Style.shared.apply(textStyle: .subhead(color: .primaryRed), to: numberOfComments)
        }
    }

    var data: Post? {
        didSet {
            if let newTitle = data?.title {
                title.text = newTitle
            }
            if let newBody = data?.body {
                bodyComment.text = newBody
            }
            if let postId = data?.id {
                let noOfComents = RealmService.shared.getNumberOfCommentOn(postId)
                if noOfComents > 0 {
                    numberOfComments.text = "\(noOfComents) comment\(noOfComents == 1 ? "" : "s")"
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
