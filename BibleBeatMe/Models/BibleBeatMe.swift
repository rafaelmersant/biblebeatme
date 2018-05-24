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
    static var language: String?

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

        //Function to get if user exists
        static func userExist(userName: String, completion: @escaping (Bool) -> Void) {

            if userName != "" {

                Database.database().reference().child("Users").queryOrdered(byChild: "userName").queryEqual(toValue: userName).observeSingleEvent(of: .value) { (snapshot) in

                    completion(snapshot.exists())
                }
            } else {

                completion(false)
            }
        }

        //Function to login into
        //Prepare user default login/register
        static func prepareUserAutoLogin(completion: @escaping (UserBB) -> Void) {

            var user = UserBB()

            if let BBUser = retrieveDataUserInfo(key: UserInfo.BBuser) as? NSDictionary {

                do {

                    user = try FirebaseDecoder().decode(UserBB.self, from: BBUser)

                } catch let error {
                    print(error)
                }

                completion(user)

            } else {

                Database.database().reference().child("Users").observeSingleEvent(of: .value, with: { (snapshot) in

                    guard let value = snapshot.value else {
                        print("Failed trying to get last User from Database.")
                        return
                    }

                    do {
                        let users = try FirebaseDecoder().decode([UserBB].self, from: value)

                        if let lastUser = users.last {

                            let nextGuestId = lastUser.userGuestId + 1
                            user.userGuestId = nextGuestId

                            let userToSave = try FirebaseEncoder().encode(user)

                            Database.database().reference().child("Users/\(user.userGuestId)").setValue(userToSave)

                            saveDataUserInfo(info: userToSave, key: UserInfo.BBuser)

                            print("Users : \(userToSave)")
                        }

                        completion(user)

                    } catch let error {
                        print(error)
                    }
                })
            }
        }

    }
}
