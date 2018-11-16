//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Avishek Thapa Magar on 11/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var RTLabel: UILabel!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var RTButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let tweet = tweet {
            self.profileImage.af_setImage(withURL:(tweet.user?.profilePic!)!)
            
            self.authorLabel.text = tweet.user?.name
            
            self.screenNameLabel.text = tweet.user?.screenName
            
            self.tweetLabel.text = tweet.text
            
            self.timestampLabel.text = tweet.createdAtString
            
            if (tweet.retweetCount == 0)
            {
                RTLabel.text = " "
            } else {
                self.RTLabel.text = String(tweet.retweetCount!)
            }
            
            if (tweet.favoriteCount == 0)
            {
                favLabel.text = " "
            } else {
                favLabel.text = String(tweet.favoriteCount!)
            }
            
            if (tweet.retweeted == true)
            {
                RTButton.isSelected = true
            } else {
                RTButton.isSelected = false
            }
            
            if (tweet.favorited == true)
            {
                favButton.isSelected = true
            } else {
                favButton.isSelected = false
            }
            
        }
    }

    @IBAction func didRT(_ sender: Any) {
        if (RTButton.isSelected != true) {
            
            RTButton.isSelected = true
            tweet.retweeted = true
            tweet.retweetCount! += 1
            self.RTLabel.text = String(tweet.retweetCount!)
            self.RTButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
            
            //APIManager Request from Cell
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else if (RTButton.isSelected == true) {
            RTButton.isSelected = false
            tweet.retweeted = false
            tweet.retweetCount! -= 1
            self.RTLabel.text = String(tweet.retweetCount!)
            self.RTButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
            //APIManager Request from Cell
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
    }
    
    @IBAction func didFav(_ sender: Any) {
        if (favButton.isSelected != true) {
            
            favButton.isSelected = true
            tweet.favorited = true
            tweet.favoriteCount! += 1
            self.favLabel.text = String(tweet.favoriteCount!)
            self.favButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
            
            //APIManager Request from Cell
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else if (favButton.isSelected == true) {
            favButton.isSelected = false
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            self.favLabel.text = String( tweet.favoriteCount!)
            self.favButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
            
            //APIManager Request from Cell
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
