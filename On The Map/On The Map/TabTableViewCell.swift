//
//  TabTableViewCell.swift
//  On The Map
//
//  Created by Kiko Santos on 21/10/18.
//  Copyright © 2018 Kiko Santos. All rights reserved.
//

import UIKit

class TabTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
