//
//  ViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 1/1/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import SwiftIcons

class MainViewController: UIViewController {

    @IBOutlet var specialButtons            : [UIButton]!
    @IBOutlet weak var mainView             : UIView!
    @IBOutlet weak var titleApp             : UILabel!
    @IBOutlet weak var opponentsInvitations : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set background Color
        mainView.backgroundColor = backColor

        //Set others formats
        titleApp.textColor = mainColor
        opponentsInvitations.layer.cornerRadius = opponentsInvitations.frame.width / 2
        opponentsInvitations.layer.borderWidth = 1
        opponentsInvitations.layer.borderColor = mainColor.cgColor
        opponentsInvitations.layer.masksToBounds = true
        opponentsInvitations.clipsToBounds = true

        //Set border to buttons
        specialButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(mainColor, for: .normal)
            button.backgroundColor = backColor
        }

        //Notification number (invitation --> Challenges Received)
        let NotiChallengesGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.recentsChallengesReceived))
        NotiChallengesGesture.numberOfTapsRequired = 1
        opponentsInvitations.isUserInteractionEnabled = true
        opponentsInvitations.addGestureRecognizer(NotiChallengesGesture)

    }

    @objc func recentsChallengesReceived() {
        print("Go to Challenges Received......")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}

