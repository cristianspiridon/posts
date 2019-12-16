//
//  PostsTableViewCell.swift
//  PostsAndComments
//
//  Created by Cristian Spiridon on 16/12/2019.
//  Copyright © 2019 cs. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!{
        didSet{
            
        }
    }
    @IBOutlet weak var bodyComment: UITextView!
    @IBOutlet weak var numberOfComments: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
