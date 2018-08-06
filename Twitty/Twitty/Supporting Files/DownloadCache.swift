//
//  DownloadCache.swift
//  Twitty
//
//  Created by Kishan nakum on 06/08/18.
//  Copyright © 2018 Kishan Nakum. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()
class Download {
    
    class func downloadImageFrom(url: URL,imgView :UIImageView) {
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            imgView.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if error != nil{
                    print(error?.localizedDescription)
                    return
                }
                //                guard let data = data, error == nil else { return }
                
                if let imageToCache = UIImage(data: data!) {
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                }
                
                DispatchQueue.main.async {
                    imgView.image = UIImage(data: data!)
                    if(imgView.image == nil){
                        print(url.absoluteURL)
                        imgView.image = #imageLiteral(resourceName: "plchldr");
                    }
                }
                
                }.resume()
        }
    }
}
