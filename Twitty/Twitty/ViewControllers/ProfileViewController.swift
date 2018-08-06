//
//  ProfileViewController.swift
//  Twitty
//
//  Created by Kishan nakum on 05/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore

class ProfileViewController: UIViewController {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var profileView: ProfileImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var TWUser : TwitterUser!
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI(){
        Download.downloadImageFrom(url: TWUser.profileURLhd!, imgView: profileView)
        userNameLabel.text = TWUser.name!
        emailLabel.text = TWUser.email!
        displayNameLabel.text = "@"+TWUser.screenName!
    }
    
    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func buttonClicked(_ sender: Any) {
        if isNetworkAvailable(){
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let control = storyBoard.instantiateViewController(withIdentifier:Identifier.friendsController.rawValue) as? FriendsViewController
        control?.screenName = TWUser.screenName!
        control?.getDataFor = (sender as AnyObject).tag == 2 ? FriendDataType.follower : FriendDataType.following
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(control!, animated: true)
    }
        }else{
            Helper.showAlert(noInternetMessage, title: noInternetTitle, controller: self)
        }
    }
    
    @IBAction func logoutButtonClicked(_ sender: Any) {
        let client = TWTRAPIClient.withCurrentUser()
        if let _ = client.userID{
            TWTRTwitter.sharedInstance().sessionStore.logOutUserID(client.userID!)
            let loader = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
            loader.center = self.view.center;
            loader.hidesWhenStopped = true
            self.view.addSubview(loader)
            loader.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            Helper.showAlert("Error getting log Out", title: "Invalid User Id", controller: self)
        }
    }
    
}
