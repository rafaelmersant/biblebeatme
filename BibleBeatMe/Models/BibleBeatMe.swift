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

    struct User {

        //Function to get user from Firebase (Database)
        //Param In: userGuestId
        static func userFromDB(guestId: Int, completion: @escaping () -> Void) {

            let user = Database.database().reference().child("Users/\(guestId)")

            user.observeSingleEvent(of: .value, with: { (snapshot) in

                guard let value = snapshot.value as? NSDictionary else {
                    print("Failed trying to get user from Database. (BibleBeatMe.userFromDB)")
                    return
                }

                do {

                    BibleBeatMe.user = try FirebaseDecoder().decode(UserBB.self, from: value)

                    completion()

                } catch let error {
                    print(error)
                }

            }) { (error) in
                print(error)
            }
        }

        //Function to update username for specify user in Firebase
        //Params In: userGuestId and userName
        static func updateUserName() {

            if let user = BibleBeatMe.user {

                do {

                    let userToSave = try FirebaseEncoder().encode(user)
                    Database.database().reference().child("Users/\(user.userGuestId)").updateChildValues(userToSave as! [AnyHashable : Any])

                } catch let error {
                    print(error)
                }
            }
        }
    }
}
