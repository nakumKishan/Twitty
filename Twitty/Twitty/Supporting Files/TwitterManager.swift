//
//  TwitterManager.swift
//  Twitty
//
//  Created by Kishan nakum on 06/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import TwitterKit

class TwitterManager {
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
        init(){
        }
    
    /* ==========================================================================
     // MARK: Custom initialization + setup methods
     ========================================================================== */

   class func getFriends(controller:FriendsViewController){
        if controller.cursor == 0 { return }
        
        var urlString = ""
        let client = TWTRAPIClient.withCurrentUser()
        if controller.getDataFor == .follower{
            urlString = TWAPI+"followers/list.json?cursor=\(controller.cursor)&screen_name=\(controller.screenName)&skip_status=true&include_user_entities=false&count=10"
        }else{
            urlString = TWAPI+"friends/list.json?cursor=\(controller.cursor)&screen_name=\(controller.screenName)&skip_status=true&include_user_entities=false&count=10"
        }
        print(urlString)
        
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", urlString: urlString, parameters: nil, error: &clientError)
        controller.loadingData = true;
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError!)")
                DispatchQueue.main.async{
                    Helper.showAlert("Unable to fetch your friends. \(connectionError?.localizedDescription ?? "")",title:"Error...", controller: controller)
                }
                return;
            }
            do {
                if let results: NSDictionary = try JSONSerialization .jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments  ) as? NSDictionary {
                    
                    if let next_cursor = results["next_cursor"] as? Int {
                        controller.cursor =  next_cursor
                    }
                    
                    if let users = results["users"] as? [[String:Any]] {
                        for user in users {
                            print(user)
                            
                            let follower = TwitterUser(name: user["name"] as! String, email: "", screenName: user["name"] as! String, hdImgUrl: user["profile_image_url"] as! String, sdImgUrl: user["profile_image_url"] as! String)
                            
                            print(follower.name!)
                            controller.followers.append(follower)
                        }
                        controller.loadingData = false
                        controller.userTableView.reloadSections(IndexSet(integersIn: 0...0), with: UITableViewRowAnimation.bottom)
                    } else {
                        print(results["errors"] ?? "")
                    }
                }
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
            }
        }
    }

}
