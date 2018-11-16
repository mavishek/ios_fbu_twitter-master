//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Avishek Thapa Magar on 11/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    
    var user: User?
    var profilePicUrl: URL?
    var bannerPicUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        user = User.current
        self.profilePicUrl = user!.profilePic
        self.bannerPicUrl = user!.bannerPic
        self.screenNameLabel.text = user!.screenName
        self.userNameLabel.text = user!.name
        self.numTweetsLabel.text = String(user!.statusCount!)+" Tweets"
        self.numFollowersLabel.text = String(user!.followerCount!)+" Followers"
        self.numFollowingLabel.text = String(user!.friendCount!)+" Following"
       
        self.profileImageView.af_setImage(withURL: profilePicUrl!)
        self.bannerImageView.af_setImage(withURL: bannerPicUrl!)
       
        profileImageView.superview?.bringSubview(toFront: profileImageView)
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
