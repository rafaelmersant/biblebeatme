//
//  User.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

struct User: Decodable {

    let userId: Int
    var isGuest: Int?
    var isActive: Int?
    var lastSeen: Date?
    var isOnline: Bool?
    var userName: String?
    var email: String?
    var userCountry: String?

    init(id: Int) {
        self.userId = id
    }
}
