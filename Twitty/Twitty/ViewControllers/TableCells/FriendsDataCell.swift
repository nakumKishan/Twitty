//
//  FriendsDataCell.swift
//  TwitterDemo
//
//  Created by ViJay Avhad on 08/07/18.
//  Copyright © 2018 ViJay Avhad. All rights reserved.
//

import UIKit

class FriendsDataCell: UITableViewCell {
    
    @IBOutlet weak var imgUser: UIImageView?
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblScreenName: UILabel!

    var index = 0
    var controller : FriendsViewController!
    var follower : TwitterUser!{
        didSet{
            lblUserName.text = follower.name
            lblScreenName.text = "@"+follower.screenName!
            Download.downloadImageFrom(url: follower.profileURLsd!, imgView: imgUser!)
            Download.downloadImageFrom(url: follower.profileURLhd!, imgView: imgUser!)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imgUser?.tag = index
            imgUser?.isUserInteractionEnabled = true
            imgUser?.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let imageView = tapGestureRecognizer.view as! UIImageView
        let userObject = controller.followers[imageView.tag]
        let newImageView = UIImageView()
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        Download.downloadImageFrom(url: userObject.profileURLsd!, imgView: newImageView)
        Download.downloadImageFrom(url: userObject.profileURLhd!, imgView: newImageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(tapGestureRecognizer:)))
        newImageView.addGestureRecognizer(tap)
        controller.view.addSubview(newImageView)
    }
    
    @objc func dismissFullscreenImage(tapGestureRecognizer: UITapGestureRecognizer) {
        tapGestureRecognizer.view?.removeFromSuperview()
    }
}

class LoadDataCell: UITableViewCell {
    
   @IBOutlet weak var loader: UIActivityIndicatorView!
   @IBOutlet weak var btnLoadMore: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

