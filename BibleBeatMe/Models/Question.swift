//
//  Question.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/9/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase

struct Question: Decodable {

    //Answers struct
    struct Answer: Decodable {
        let id          : Int
        let text        : String
        let isRight     : Bool
    }

    //Properties
    let questionId      : Int?
    let questionText    : String?
    let isActive        : Bool?
    let lastUsed        : Date?
    let languaje        : String?
    let level           : String
    let answers         : [Answer]?
}


