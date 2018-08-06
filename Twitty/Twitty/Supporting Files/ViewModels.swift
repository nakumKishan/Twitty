//
//  ViewModels.swift
//  Twitty
//
//  Created by Kishan nakum on 06/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import UIKit

class ProfileImageView: UIImageView {
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
    }
}
