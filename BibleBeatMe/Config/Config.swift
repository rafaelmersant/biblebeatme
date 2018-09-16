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

var languageBundle: AnyObject?

//MARK: UserInfo
struct UserInfo {
    static let BBUserLanguage = "language"
    static let BBuser = "BBUser"
}

func saveDataUserInfo(info: Any, key: String) {
    let _default = UserDefaults.standard
    _default.set(info, forKey: key)
}

func retrieveDataUserInfo(key: String) -> Any? {
    let _default = UserDefaults.standard

    if _default.object(forKey: key) == nil {
        saveDataUserInfo(info: "en", key: key)
    }
    return _default.object(forKey: key)
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
let darkGrayColor = hexToUIColor(hexString: "292929")

//MARK: Update language
func setDefaultLanguage(new: String? = "en") {

    //Save or retrieve language from userInfo
    if let language = retrieveDataUserInfo(key: "selectedLanguage"), new == nil {
        BibleBeatMe.language = (language as! NSString).substring(to: 2)

    } else {

        if new == nil {
            //Set default English if language is not Spanish
            if Locale.preferredLanguages.count > 0 {
                switch((Locale.preferredLanguages[0] as NSString).substring(to: 2)) {
                case "es"   : BibleBeatMe.language = "es"
                default     : BibleBeatMe.language = "en"
                }
            }
        } else {
            BibleBeatMe.language = new!
        }

        saveDataUserInfo(info: BibleBeatMe.language, key: "selectedLanguage")
    }
}

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

// MARK: Modify Multiplier for NSLayoutConstraint
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
