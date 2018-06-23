//
//  Question.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/9/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

let maxQuestions: Int = 10

final class Question {

    init() { }

    struct QuestionModel: Decodable {

        //Answers struct
        struct Answer: Decodable {
            let id          : Int
            let text_es     : String
            let text_en     : String
            let isRight     : Bool
        }

        //Properties
        let questionId      : Int?
        let questionText_es : String?
        let questionText_en : String?
        let isActive        : Bool?
        let lastUsed        : Date?
        let level           : String
        let category        : String
        let answers         : [Answer]?
    }

    //Function to get questions for game
    static func questionsToShow(completion: @escaping ([QuestionModel]?) -> Void) {
        var questionsSelected = [Question.QuestionModel]()

        Database.database().reference().child(questionsModel).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value else { return }

            do {
                let questions = try FirebaseDecoder().decode([Question.QuestionModel].self, from: value).filter {$0.isActive == true}
                let reOrderQuestions = randomArrayOrder(min: 0, max: questions.count, limit: maxQuestions)

                reOrderQuestions.forEach({ (newIndex) in
                    questionsSelected.append(questions[newIndex])
                })

                completion(questionsSelected)

            } catch let error {
                print(error)
                completion(nil)
            }
        })
    }
}
