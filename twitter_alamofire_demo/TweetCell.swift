//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Avishek Thapa Magar on 10/24/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    
    var homeTimeline: TimelineViewController?
    
    var tweet: Tweet? {
        didSet {
            if (tweet?.retweeted == true) {
                self.retweetButton.isSelected = true
            } else {
                self.retweetButton.isSelected = false
            }
            if (tweet?.favorited == true) {
                favoriteButton.isSelected = true
            } else {
                favoriteButton.isSelected = false
            }
            
            if (tweet?.retweetCount == 0)
            {
                retweetLabel.text = " "
            } else {
                favoriteLabel.text = String(tweet!.retweetCount!)
            }
            
            if (tweet?.favoriteCount == 0)
            {
                favoriteLabel.text = " "
            } else {
                favoriteLabel.text = String(tweet!.favoriteCount!)
            }
            
           // self.profilePicImage = tweet?.user!.profilePic
            self.screenNameLabel.text = tweet?.user?.screenName
            self.usernameLabel.text = tweet?.user?.name
            self.timestampLabel.text = tweet?.createdAtString
            self.tweetText.text = tweet?.text
            self.profilePicImage.af_setImage(withURL:(tweet?.user?.profilePic!)!)
            self.favoriteLabel.text = String(tweet!.favoriteCount!)
            self.retweetLabel.text = String(tweet!.retweetCount!)
        }
    }
    
    @IBAction func onTapFavorite(_ sender: Any) {
        if (favoriteButton.isSelected != true) {
            
            favoriteButton.isSelected = true
            tweet?.favorited = true
            tweet?.favoriteCount! += 1
            self.favoriteLabel.text = String(tweet!.favoriteCount!)
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: .normal)
            
            APIManager.shared.favorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.homeTimeline?.getTweets()
                }
            }
        } else if (favoriteButton.isSelected == true){
            
            favoriteButton.isSelected = false
            tweet?.favorited = false
            tweet?.favoriteCount! -= 1
            self.favoriteLabel.text = String(tweet!.favoriteCount!)
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: .normal)
            
            APIManager.shared.unfavorite(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.homeTimeline?.getTweets()

                }
            }
        }
    }
    
    @IBAction func onTapRetweet(_ sender: Any) {
        if (retweetButton.isSelected != true) {
            
            retweetButton.isSelected = true
            tweet?.retweeted = true
            tweet?.retweetCount! += 1
            self.retweetLabel.text = String(tweet!.retweetCount!)
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: .normal)
            
            APIManager.shared.retweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.homeTimeline?.getTweets()
                }
            }
        } else if(retweetButton.isSelected == true){
            
            retweetButton.isSelected = false
            tweet?.retweeted = false
            tweet?.retweetCount! -= 1
            self.retweetLabel.text = String(tweet!.retweetCount!)
            self.retweetButton.setImage(UIImage(named: "retweet-icon.png"), for: .normal)
            
            APIManager.shared.unretweet(tweet!) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.homeTimeline?.getTweets()
                }
            }
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
