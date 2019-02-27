//
//  PostsTableViewCell.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    static let name = "PostsTableViewCell"
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: PostHits) {
        titleLbl.text = post.title
        createdAtLbl.text = post.createdAt
    }
    
}
