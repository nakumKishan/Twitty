//
//  HeaderTableViewCell.swift
//  Twitty
//
//  Created by Kishan nakum on 05/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var headerLabel: UILabel!
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
