//
//  Challenge.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/9/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class Challenge {

    init() { }

    //Model for Challenges
    struct ChallengeModel: Decodable, Encodable {
        var id              : Int
        var dateSentReceived: Date?
        var userWhoSend     : Int?
        var userWhoReceive  : Int?
        var userWhoWon      : Int?
        var userWhoLosses   : Int?
        var type            : String? //Sent or Received
    }

    //Function to get user's competitions
    static func opponent(id: Int, challengeId: Int, completion: @escaping ([ChallengeModel]?) -> Void) {

        let opponent = Database.database().reference().child("Challenges/\(challengeId)").queryOrdered(byChild: "userWhoWon").queryEqual(toValue: id)

        opponent.observeSingleEvent(of: .value, with: { (snapshot) in

            guard let value = snapshot.value else { return }

            do {
                let challenges = try FirebaseDecoder().decode([Challenge.ChallengeModel].self, from: value)

                completion(challenges)

            } catch let error {
                print(error)
                completion(nil)
            }
        })
    }
}
