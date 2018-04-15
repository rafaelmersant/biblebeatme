//
//  PracticeCompetition.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class PracticeCompetition {

    //Properties
    var id              : Int?
    var competitionId   : Int?
    var started         : Date?
    var ended           : Date?
    var status          : String?
    var questions       : [[String: Int]]?
    var answeredRights  : [Int]?
    var answeredWrongs  : [Int]?
    var questionsAnswered: [Int]?
    var userWhoComplete : User?

    //default constructor
    init() {}

}

