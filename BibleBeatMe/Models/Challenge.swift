//
//  Challenge.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/9/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class Challenge {

    //Properties
    let challengeId: Int
    var dateSentReceived: Date?
    var userWhoSend: User.UserBB?
    var userWhoReceive: User.UserBB?
    var userWhoWon: User.UserBB?
    var userWhoLosses: User.UserBB?
    var type: String? //Sent or Received

    init(id: Int) {
        self.challengeId = id
    }
}
