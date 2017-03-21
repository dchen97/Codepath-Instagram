//
//  PostViewCell.swift
//  parsetagram
//
//  Created by Diana C on 3/14/17.
//  Copyright © 2017 Diana C. All rights reserved.
//

import UIKit

class PostViewCell: UITableViewCell {
    @IBOutlet weak var instaImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
