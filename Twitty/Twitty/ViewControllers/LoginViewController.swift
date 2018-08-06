//
//  ViewController.swift
//  Twitty
//
//  Created by Kishan nakum on 05/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var loginButtonContainerView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var noConnectionLabel: UILabel!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    fileprivate var screenName  = ""
    fileprivate var TWLoggedInUser : TwitterUser?

    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkForConnectivity()
    }
    
    func checkForConnectivity(){
        if isNetworkAvailable(){
            loginButtonContainerView.isHidden = false
            noConnectionLabel.isHidden = true
            refreshButton.isHidden = true
            checkForTwitterUser()
        }else{
            noConnectionLabel.isHidden = false
            loginButtonContainerView.isHidden = true
            Helper.showAlert(noInternetMessage, title: noInternetTitle, controller: self)
            refreshButton.isHidden = false
        }
    }
    
    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func twitterButtonPressed(_ sender: Any) {
        if isNetworkAvailable(){
        TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                self.screenName = session!.userName
                self.getUserDetails(TWTRAPIClient.withCurrentUser())
            } else {
                print("error: \(String(describing: error?.localizedDescription))");
                Helper.showAlert("\(String(describing: error!.localizedDescription))", title: "Error...", controller: self)
            }
        })
        }else{
            Helper.showAlert(noInternetMessage, title: noInternetTitle, controller: self)
        }
    }

    @IBAction func refreshButtonClicked(_ sender: Any) {
        checkForConnectivity()
    }
    /* ==========================================================================
     // MARK: Custom initialization + setup methods
     ========================================================================== */
    func checkForTwitterUser(){
        let client = TWTRAPIClient.withCurrentUser()
        if let _ = client.userID{
            DispatchQueue.main.async {
                self.loginButtonContainerView.isHidden = true
                Helper.addLoaderToViewController(controller: self)
            }
            getUserDetails(client)
        }else{
            self.loginButtonContainerView.isHidden = false
        }
    }

    func getUserDetails(_ client: TWTRAPIClient){
        var emailId = ""
        if let uId = client.userID{
            client.requestEmail { email, error in
                if (email != nil) {
                        emailId = email!
                }
                client.loadUser(withID: uId) { (user, error) in
                    if user != nil{
                        self.TWLoggedInUser =  TwitterUser(name: user!.name, email: emailId, screenName: user!.screenName, hdImgUrl: user!.profileImageURL, sdImgUrl: user!.profileImageURL)
                        self.goToUserProfile(self.TWLoggedInUser!)
                    }
                }

            }
        }
    }

    /* ==========================================================================
     // MARK: Navigation
     ========================================================================== */
    func goToUserProfile(_ user : TwitterUser){
              let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
              let control = storyBoard.instantiateViewController(withIdentifier: Identifier.profileController.rawValue) as? ProfileViewController
                control?.TWUser = user
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(control!, animated: true)
        }
    }
}


