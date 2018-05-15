//
//  User.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase

struct UserBB: Decodable, Encodable {

    var userGuestId : Int = 0
    var isActive    : Int
    var isOnline    : Bool = true
    var userName    = ""
    var email       = ""
    var userCountry = ""
    var lastSeen    = Date().timeIntervalSince1970

    init() {
        self.isActive = 1
    }
}

//class User: NSObject {
//
//    func lastUserFromDB() {
//
//        Database.database().reference().child("Users").observeSingleEvent(of: .value) { (snapshot) in
//
//            guard let users = snapshot.value else { return }
//
//        }
//    }
//}
