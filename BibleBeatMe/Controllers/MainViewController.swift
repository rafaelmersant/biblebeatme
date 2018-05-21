//
//  ViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 1/1/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import SwiftIcons

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet var specialButtons            : [UIButton]!
    @IBOutlet weak var mainView             : UIView!
    @IBOutlet weak var titleApp             : UILabel!
    @IBOutlet weak var opponentsInvitations : UILabel!
    @IBOutlet weak var userLogged           : UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set user info in the app
        if BibleBeatMe.user == nil {

            prepareUserAutoLogin { (user) in

                BibleBeatMe.userFromDB(guestId: user.userGuestId, completion: { () in

                    if let user = BibleBeatMe.user {
                        self.userLogged.title = user.usernameToDisplay()
                    }
                })
            }
        }

        //Set background Color
        mainView.backgroundColor = backColor

        //Set others formats
        titleApp.textColor = mainColor
        opponentsInvitations.layer.cornerRadius = opponentsInvitations.frame.width / 2
        opponentsInvitations.layer.borderWidth = 1
        opponentsInvitations.layer.borderColor = mainColor.cgColor
        opponentsInvitations.layer.masksToBounds = true
        opponentsInvitations.clipsToBounds = true

        userLogged.tintColor = UIColor.lightGray

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

    @IBAction func showUserProperties(_ sender: AnyObject) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "storyboardUser") as! UserPropertiesViewController
        vc.preferredContentSize = CGSize(width: 300, height: 200)

        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .popover
        navController.navigationBar.barTintColor = darkGrayColor
        navController.navigationBar.tintColor = UIColor.white

        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.backgroundColor = darkGrayColor //navController.view.backgroundColor
        popOver?.barButtonItem = sender as? UIBarButtonItem

        self.present(navController, animated: true, completion: nil)
    }

    //Action for notification about challenges received
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

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

