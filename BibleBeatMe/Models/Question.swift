//
//  Question.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/9/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class Question {

    //Properties
    var questionId      : Int?
    var questionText    : String?
    var isActive        : Bool?
    var lastUsed        : Date?
    var languaje        : String?
    var answers         : [Answer]?

    //default constructor
    init() {}

    convenience init(questionText: String) {
        self.init()

        self.questionText = questionText
    }

    struct Answer {
        let id          : Int
        let text        : String
        let isTheRight  : Bool
    }

}
