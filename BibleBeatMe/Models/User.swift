//
//  User.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class User {

    init() {}

    struct UserModel: Decodable, Encodable {

        var userGuestId : Int = 0
        var isActive    : Int
        var isOnline    : Bool = true
        var userName    = ""
        var email       = ""
        var userCountry = Locale.current.regionCode
        var lastSeen    = Date().timeIntervalSince1970

        init() {
            self.isActive = 1
        }

        func usernameToDisplay() -> String? {

            if self.userName == "" {
                return "G\(self.userGuestId)"
            } else {
                return self.userName
            }
        }
    }

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

                BibleBeatMe.user = try FirebaseDecoder().decode(User.UserModel.self, from: value)

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
            Database.database().reference().child("Users/\(user.userGuestId)").updateChildValues(["userName" : user.userName])
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

    //Function to set Online or Offline user
    static func userOnline(status: Bool) {

        if let user = BibleBeatMe.user {
            Database.database().reference().child("Users/\(user.userGuestId)").updateChildValues(["isOnline" : status, "lastSeen" : Date().timeIntervalSince1970])
        }
    }

    //Function to login into
    //Prepare user default login/register
    static func prepareUserAutoLogin(completion: @escaping (UserModel) -> Void) {

        var user = UserModel()

        if let BBUser = retrieveDataUserInfo(key: UserInfo.BBuser) as? NSDictionary {

            do {

                user = try FirebaseDecoder().decode(UserModel.self, from: BBUser)

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
                    let users = try FirebaseDecoder().decode([UserModel].self, from: value)

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
