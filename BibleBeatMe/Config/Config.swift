//
//  Config.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/17/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

//Database models Strings
let questionsModel = "Questions"
let usersModel = "Users"

//MARK: UserInfo
struct UserInfo {
    static let BBUserGuestId = "BBGuestId"
    static let BBUserName = "BBUserName"
}

func saveDataUserInfo(info: Any, key: String) {
    let _default = UserDefaults.standard
    _default.set(info, forKey: key)
}

func retrieveDataUserInfo(key: String) -> Any? {
    let _default = UserDefaults.standard
    return _default.object(forKey: key)
}

//Prepare user default login/register
func prepareUserAutoLogin(completion: @escaping (UserBB) -> Void) {

    var user = UserBB()

    if let userGuestId = retrieveDataUserInfo(key: UserInfo.BBUserGuestId) as? Int {

        user.userGuestId = userGuestId
        user.isOnline = true

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

                    saveDataUserInfo(info: nextGuestId, key: UserInfo.BBUserGuestId)

                    user.userGuestId = nextGuestId

                    let userToSave = try FirebaseEncoder().encode(user)

                    Database.database().reference().child("Users/\(users.count)").setValue(userToSave)

                    print("Users : \(userToSave)")
                }

                completion(user)

            } catch let error {
                print(error)
            }
        })
    }
}

//MARK: Convert hex color to UIColor

func hexToUIColor (hexString: String) -> UIColor {
    var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//MARK: General properties / values
let mainColor = hexToUIColor(hexString: "FF0033")
let backColor = UIColor.black
let foreColor = UIColor.black

//MARK: random
func randomNumber(min: Int, max: Int)-> Int {
    return Int(arc4random_uniform(UInt32(max - min)) + UInt32(min));
}

func randomArrayOrder(min: Int, max: Int, limit: Int) -> [Int] {
    var reOrderRandom = [Int]()

    while(reOrderRandom.count < limit) {

        let index = randomNumber(min: min, max: max)

        if !reOrderRandom.contains( Int(index) ) {
            reOrderRandom.append( Int(index) )
        }
    }

    return reOrderRandom
}

//Convert to get hours, minutes and seconds
func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

//MARK: Modify Multiplier for NSLayoutConstraint
extension NSLayoutConstraint {
    /**
     Change multiplier constraint

     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        NSLayoutConstraint.deactivate([self])

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier

        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
