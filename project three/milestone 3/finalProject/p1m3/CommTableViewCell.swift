//
//  CommTableViewCell.swift
//  p1m3
//
//  Created by Mae Patton on 5/7/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import UIKit

class CommTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
