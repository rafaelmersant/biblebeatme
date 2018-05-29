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
    var userWhoSend: User.UserModel?
    var userWhoReceive: User.UserModel?
    var userWhoWon: User.UserModel?
    var userWhoLosses: User.UserModel?
    var type: String? //Sent or Received

    init(id: Int) {
        self.challengeId = id
    }
}
