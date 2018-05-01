//
//  PracticeCompetition.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

struct StatusGame {
    static let inProgress   = "In progress"
    static let canceled     = "Canceled"
    static let completed    = "Completed"
    static let aborted      = "Aborted"
}

struct Game: Decodable {

    //Properties
    //let id                  : Int?
    private let started     = Date().timeIntervalSince1970
    let competitionId       : Int?
    let ended               : Date?
    let status              = StatusGame.inProgress //In progress, Canceled, Completed
    let questions           : [[String: Int]]? //
    let answeredRights      : [Int]?
    let answeredWrongs      : [Int]?
    let questionsAnswered   : [Int]?
    let userWhoComplete     : User?
}

