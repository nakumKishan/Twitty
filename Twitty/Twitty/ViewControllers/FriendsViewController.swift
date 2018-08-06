//
//  DashboardViewController.swift
//  Twitty
//
//  Created by Kishan nakum on 05/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import UIKit
import TwitterKit
import TwitterCore

class FriendsViewController: UIViewController {

    /* ==========================================================================
     // MARK: IBOutlets
     ========================================================================== */
    @IBOutlet weak var userTableView: UITableView!
    
    /* ==========================================================================
     // MARK: Internal variables
     ========================================================================== */
    var TWUser : TwitterUser!
    var strechView = HeaderTableViewCell()
    var screenName  = ""
    var getDataFor  = FriendDataType.follower
    var cursor = -1
    var loadingData = false
    var count = 10
    var followers = [TwitterUser]()
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTable()
        initializeStrechView()
        cursor = -1
        TwitterManager.getFriends(controller: self)
    }
 
    /* ==========================================================================
     // MARK: Custom initialization + setup methods
     ========================================================================== */
    func customizeTable(){
        userTableView.estimatedRowHeight = 50
        userTableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0)
        userTableView.delegate = self
        userTableView.dataSource = self
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        userTableView.tableFooterView = customView;
    }
    
    func initializeStrechView(){
        strechView  = userTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        strechView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100)
        strechView.clipsToBounds = true
        if getDataFor == .follower{
            strechView.headerLabel.text = FriendDataType.follower.rawValue
        }else{
            strechView.headerLabel.text = FriendDataType.following.rawValue
        }
        view.addSubview(strechView)
    }
    
    /* ==========================================================================
     // MARK: IBActions
     ========================================================================== */
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

/* ==========================================================================
 // MARK: Extension : UITableView
 ========================================================================== */
extension FriendsViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if followers.isEmpty{ return 0 }
        return self.cursor == 0 ? followers.count : followers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Display last cell as loader for paging.
        if indexPath.row == followers.count && self.cursor != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadDataCell", for: indexPath) as! LoadDataCell
            cell.btnLoadMore.isHidden = false
            cell.loader.isHidden = true
            cell.btnLoadMore.addTarget(self, action: #selector(loadMoreFriends(sender:)), for: UIControlEvents.touchUpInside)
            return cell
        }
        //Display User
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsDataCell", for: indexPath) as! FriendsDataCell
        if followers.isEmpty{ return cell }
        cell.controller = self
        cell.index = indexPath.row
        cell.follower = followers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    /* ==========================================================================
     // MARK: ScrollView delegate
     ========================================================================== */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 100 - (scrollView.contentOffset.y + 100)
        let height = min(max(y, 60), 400)
        strechView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }

    /* ==========================================================================
     // MARK: Custom methods
     ========================================================================== */
    @objc func loadMoreFriends(sender : UIButton){
    if isNetworkAvailable(){
            if let cell = sender.superview?.superview as? LoadDataCell {
                cell.btnLoadMore.isHidden  = true
                cell.loader.isHidden = false
                cell.loader.startAnimating()
                TwitterManager.getFriends(controller: self)
            }
        }else{
            Helper.showAlert(noInternetMessage, title: noInternetTitle, controller: self)
        }
    }
}

