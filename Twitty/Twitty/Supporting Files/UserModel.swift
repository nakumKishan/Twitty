//
//  UserModel.swift
//  Twitty
//
//  Created by Kishan nakum on 06/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation

struct TwitterUser {
    
    /* ==========================================================================
     // MARK:  variables
     ========================================================================== */
    var name: String?
    var email: String?
    var screenName: String?
    var profileURLsd: URL?
    var profileURLhd: URL?
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    init (name: String, email:String, screenName: String, hdImgUrl: String, sdImgUrl: String) {
        self.name = name
        self.email = email
        self.screenName = screenName
        if let url1 = URL(string: hdImgUrl.replacingOccurrences(of: "_normal", with: "")){
            profileURLhd = url1
        }
        if let url2 = URL(string: sdImgUrl){
            profileURLsd = url2
        }
    }
}
