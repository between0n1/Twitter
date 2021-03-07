//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by sunhyeok on 2021/02/23.
//  Copyright © 2021 Dan. All rights reserved.
//
import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    var indexPath_for_profile: IndexPath!

    
    let myrefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        myrefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myrefreshControl
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.loadTweets()
    }

    
    @objc func loadTweets(){
         
          numberOfTweet = 20
         
         let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
         let myParams = ["count": numberOfTweet]
         
         TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
             
             self.tweetArray.removeAll()
             for tweet in tweets{
                 self.tweetArray.append(tweet)
             }
             self.tableView.reloadData()
             self.myrefreshControl.endRefreshing()
         }, failure: { (Error) in
             print("Could not retreive tweets \(Error)")
         })
     }
    
    func loadmoreTweets(){
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = numberOfTweet + 20
        let myParams = ["count": numberOfTweet]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
        }, failure: { (Error) in
            print("Could not retreive tweets \(Error)")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count {
            loadmoreTweets()
        }
    }
    
    
    
    
    
    @IBAction func OnLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userNameLabel.text = user["name"] as! String
        cell.tweetContentLabel.text = (tweetArray[indexPath.row]["text"] as! String)
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openProfile(_:)))
        cell.profileImageView.addGestureRecognizer(tapGesture)

        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        return cell
    }
    
    @objc func openProfile(_ sender: UITapGestureRecognizer){
        let point = sender.view
        let mainCell = point?.superview
        let main = mainCell?.superview
        let cell: TweetCellTableViewCell = main as! TweetCellTableViewCell
        indexPath_for_profile = tableView.indexPath(for: cell)
        self.performSegue(withIdentifier: "goToProfile", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile" {
            let vc = segue.destination as! UINavigationController
            let svc = vc.topViewController as! ProfileViewController
        // to pass the indexpath of the selected image.
            svc.user = tweetArray[indexPath_for_profile.row]["user"] as! NSDictionary
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

  

}
