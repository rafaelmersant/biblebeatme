//
//  Config.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/17/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

//Database models Strings
let questionsModel = "Questions"
let usersModel = "Users"

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

func randomArrayOrder(min: Int, max: Int) -> [Int] {
    var reOrderRandom = [Int]()

    while(reOrderRandom.count < max) {

        let index = randomNumber(min: min, max: max)

        if !reOrderRandom.contains( Int(index) ) {
            reOrderRandom.append( Int(index) )
        }
    }

    return reOrderRandom
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
