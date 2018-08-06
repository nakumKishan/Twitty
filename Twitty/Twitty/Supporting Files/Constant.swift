//
//  Constant.swift
//  Twitty
//
//  Created by Kishan nakum on 06/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import UIKit

/* ==========================================================================
 // MARK: Alert Messages
 ========================================================================== */
let noInternetTitle = "No Interner connectivity available"
let noInternetMessage = "Turn on your Internet connection and try again."

/* ==========================================================================
 // MARK: Constant Variables
 ========================================================================== */
let TWAPI  = "https://api.twitter.com/1.1/"
let storyBoardName = "Main"

/* ==========================================================================
 // MARK: Storyboard Identifiers
 ========================================================================== */
enum Identifier:String {
    case profileController = "ProfileViewController"
    case friendsController = "FriendsViewController"
}

/* ==========================================================================
 // MARK: Twitter Friends Type
 ========================================================================== */
enum FriendDataType : String {
    case follower = "Followes"
    case following = "Friends"
}
