//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-10-05.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName: String?
    /*var profilePic: URL?
    var bannerPic: URL?
    var friendCount: Int?
    var followerCount: Int?
    var userid: Int?
    var favoriteCount: Int?
    var statusCount: Int?*/
    
    init(dictionary: [String : Any]) {
        super.init()
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
    }
    
    static var current: User?
    
}
