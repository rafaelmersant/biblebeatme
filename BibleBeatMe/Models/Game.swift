//
//  PracticeCompetition.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class Game {

    init() {}

    struct StatusGame {
        static let inProgress   = "In progress"
        static let canceled     = "Canceled"
        static let completed    = "Completed"
        static let aborted      = "Aborted"
    }

    struct GameModel: Decodable, Encodable {

        //Properties
        private let started     = Date().timeIntervalSince1970
        var competitionId       : Int?
        var ended               : TimeInterval?
        var status              = StatusGame.inProgress //In progress, Canceled, Completed
        var questions           : [Int]? //
        var answeredRights      = [Int]()
        var answeredWrongs      = [Int]()
        var questionsAnswered   = [Int]()
        var userWhoComplete     : Int?

        init() {}

        init(competitionId: Int?) {
            self.init()
            self.competitionId = competitionId
        }

        init(questions: [Int]) {
            self.init()
            self.questions = questions
        }
    }

    //Set user to game
    private static func userOwnerGame() {
        if let user = BibleBeatMe.user, let _ = BibleBeatMe.game {
            BibleBeatMe.game?.userWhoComplete = user.userGuestId
        }
    }

    //Start new game (for competition)
    static func start(competitionId: Int?) {
        BibleBeatMe.game = GameModel(competitionId: competitionId)
        userOwnerGame()
    }

    //End the game
    static func end(status: String) {

        if let _ = BibleBeatMe.game {
            BibleBeatMe.game?.ended = Date().timeIntervalSince1970
            game(status: status)

            saveGame()
        }
    }

    //Set questions for game
    static func questionsForGame(questions: [Int]) {

        if let _ = BibleBeatMe.game {
            BibleBeatMe.game?.questions = questions
            userOwnerGame()
        }
    }

    //Answer question
    static func answerQuestion(questionId: Int, right: Bool) {

        if let _ = BibleBeatMe.game {
            if right == true {
                BibleBeatMe.game?.answeredRights.append(questionId)
            } else {
                BibleBeatMe.game?.answeredWrongs.append(questionId)
            }

            BibleBeatMe.game?.questionsAnswered.append(questionId)
        }
    }

    //Set status for game
    static func game(status: String) {
        if let _ = BibleBeatMe.game {
            BibleBeatMe.game?.status = status
        }
    }

    //Save the game in firebase
    static func saveGame() {

        Database.database().reference().child("Games").observeSingleEvent(of: .value, with: { (snapshot) in

            guard let value = snapshot.value else {
                print("Failed trying to get last User from Database.")
                return
            }

            do {
                let games = try FirebaseDecoder().decode([GameModel].self, from: value)

                let nextGameId = games.count

                if let game = BibleBeatMe.game {

                    let gameToSave = try FirebaseEncoder().encode(game)
                    Database.database().reference().child("Games/\(nextGameId)").setValue(gameToSave)

                    saveDataUserInfo(info: gameToSave, key: "GameInfo")

                    print("Game : \(gameToSave)")
                }

            } catch let error {
                print(error)
            }
        })
    }
}
