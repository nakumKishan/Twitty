//
//  Helper.swift
//  Twitty
//
//  Created by Kishan nakum on 06/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import UIKit

class Helper{
    
    /* ==========================================================================
     // MARK: Overrides + instantiation
     ========================================================================== */
    init() {
        
    }
 
    /* ==========================================================================
     // MARK: Custom initialization + setup methods
     ========================================================================== */
   class func showAlert(_ message: String="Default message",title:String = "",controller:UIViewController){
        let alertController = UIAlertController(title: title,  message: message, preferredStyle:.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { action -> Void in
        })
        DispatchQueue.main.async {
        controller.present(alertController, animated: true, completion: nil)
        }
    }

    class func addLoaderToViewController(controller:UIViewController){
        let loader = UIActivityIndicatorView.init(activityIndicatorStyle: .white)
        loader.center = controller.view.center;
        loader.hidesWhenStopped = true
        controller.view.addSubview(loader)
        loader.startAnimating()
        }
}


