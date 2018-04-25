//
//  PracticeCompetition.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

struct Status {
    static let inProgress   = "In progress"
    static let canceled     = "Canceled"
    static let completed    = "Completed"
}

struct PracticeCompetition: Decodable {

    //Properties
    let id                  : Int?
    let competitionId       : Int?
    let started             = Date().timeIntervalSince1970
    let ended               : Date?
    let status              = Status.inProgress //In progress, Canceled, Completed
    let questions           : [[String: Int]]? //
    let answeredRights      : [Int]?
    let answeredWrongs      : [Int]?
    let questionsAnswered   : [Int]?
    let userWhoComplete     : User?
}

