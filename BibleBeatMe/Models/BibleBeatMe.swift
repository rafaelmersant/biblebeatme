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
import Localize_Swift

class BibleBeatMe {

    static var user: User.UserModel?
    static var game: Game.GameModel?
    static var language = "en" {
        didSet {
            Localize.setCurrentLanguage(language)
        }
    }
}
