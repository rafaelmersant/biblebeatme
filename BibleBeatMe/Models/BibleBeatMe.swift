//
//  File.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 5/20/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import Foundation
import Firebase
import CodableFirebase


class BibleBeatMe {

    static var user: UserBB?

    static func userFromDB(guestId: Int, completion: @escaping () -> Void) {

        let users = Database.database().reference().child("Users")
        let data = users.child("16") //queryOrdered(byChild: "userGuestId").queryEqual(toValue: guestId).queryLimited(toFirst: 1)

        data.observeSingleEvent(of: .value, with: { (snapshot) in

            guard let value = snapshot.value else {
                print("Failed trying to get user from Database. (BibleBeatMe.userFromDB)")
                return
            }

            do {

                self.user = try FirebaseDecoder().decode(UserBB.self, from: value)

                completion()

            } catch let error {
                print(error)
            }

        }) { (error) in
            print(error)
        }
    }
}
