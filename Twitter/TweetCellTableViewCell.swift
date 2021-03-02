//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by sunhyeok on 2021/02/24.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetbutton: UIButton!
    @IBOutlet weak var favbutton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("did not succeed: \(Error)")
        })
    }
    
    var favorited:Bool = false
    var tweetId:Int = -1
    
    
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            retweetbutton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetbutton.isEnabled = false
        }
        else{
            retweetbutton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetbutton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            favbutton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favbutton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
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

}
