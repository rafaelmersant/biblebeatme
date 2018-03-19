//
//  Config.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/17/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit


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
let mainColor = UIColor(red: 0.80, green: 0.00, blue: 0.20, alpha: 1.0)
