//
//  GameCell.swift
//  FBTechGame
//
//  Created by SenthilKumar on 9/27/17.
//  Copyright © 2017 personal. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet var scoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
