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
    var userCountry = Locale.current.regionCode
    var lastSeen    = Date().timeIntervalSince1970

    init() {
        self.isActive = 1
    }

    func usernameToDisplay() -> String? {
        
        if self.userName == "" {
            return "G\(self.userGuestId)"
        } else {
            return self.userName
        }
    }
}
