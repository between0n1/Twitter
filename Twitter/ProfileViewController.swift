//
//  ProfileViewController.swift
//  Twitter
//
//  Created by sunhyeok on 2021/03/03.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var UserProfileImage: UIImageView!
    @IBOutlet weak var UserBannerImage: UIImageView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserCommentLabel: UILabel!
    @IBOutlet weak var UserFollowingNumberLabel: UILabel!
    @IBOutlet weak var UserFollowersNumberLabel: UILabel!
    
    
    var user = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = (user["name"] as! String)
        print(user)
        load_profile()
        // Do any additional setup after loading the view.
    }
    
    func load_profile(){
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let bannerUrl = URL(string: (user["profile_banner_url"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        let data_banner = try? Data(contentsOf: bannerUrl!)
        if let imageData = data { // load data and make it be circular shape
            self.UserProfileImage.image = UIImage(data: imageData)
            self.UserProfileImage.layer.borderWidth = 3.0
            self.UserProfileImage.layer.masksToBounds = false
            self.UserProfileImage.layer.borderColor = UIColor.white.cgColor
            self.UserProfileImage.layer.cornerRadius = (UserProfileImage.frame.size.width) / 2
            self.UserProfileImage.clipsToBounds = true
        }
        if let banner_imageData = data_banner{
            self.UserBannerImage.image = UIImage(data: banner_imageData)
        }
        
        self.UserNameLabel.text = user["name"] as! String
        self.UserCommentLabel.text = user["description"] as! String
        
        self.UserFollowingNumberLabel.text = String(format: "%@", user["friends_count"] as! CVarArg)
        self.UserFollowersNumberLabel.text = String(format: "%@", user["followers_count"] as! CVarArg)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
