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

    let titleButtons = ["practice", "competition", "scores"]

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set user info in the app
        User.prepareUserAutoLogin { (user) in

            User.userFromDB(guestId: user.userGuestId, completion: { () in

                if let user = BibleBeatMe.user {
                    self.userLogged.title = user.usernameToDisplay()
                    User.userOnline(status: true)
                }
            })
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
            button.setTitle(titleButtons[button.tag].localized(), for: .normal)
        }

        //Notification number (invitation --> Challenges Received)
        let NotiChallengesGesture = UITapGestureRecognizer(target: self, action: #selector(MainViewController.recentsChallengesReceived))
        NotiChallengesGesture.numberOfTapsRequired = 1
        opponentsInvitations.isUserInteractionEnabled = true
        opponentsInvitations.addGestureRecognizer(NotiChallengesGesture)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let notificationCenter = NotificationCenter.default

        // observe the filter attribute add/change notifications.
        notificationCenter.addObserver(self, selector: #selector(MainViewController.refreshUserNameAndLanguage(_:)),
                                       name: NSNotification.Name(rawValue: "refreshUserNameAndLanguage"), object: nil)
    }

    //MARK: deinit
    deinit {

        NotificationCenter.default.removeObserver(self)
    }

    //MARK: IBActions

    @IBAction func showUserProperties(_ sender: AnyObject) {

        let vc = storyboard?.instantiateViewController(withIdentifier: "storyboardUser") as! UserPropertiesViewController
        vc.preferredContentSize = CGSize(width: 300, height: 200)

        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .popover
        navController.navigationBar.barTintColor = darkGrayColor
        navController.navigationBar.tintColor = UIColor.white

        let popOver = navController.popoverPresentationController
        popOver?.delegate = self
        popOver?.backgroundColor = darkGrayColor
        popOver?.barButtonItem = sender as? UIBarButtonItem

        self.present(navController, animated: true, completion: nil)
    }

    //Action for notification about challenges received
    @objc func recentsChallengesReceived() {
        print("Go to Challenges Received......")
    }

    // MARK: Overrides

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

    // MARK: Notifications

    @objc func refreshUserNameAndLanguage(_ notification: Notification) {

        if let user = BibleBeatMe.user {
            userLogged.title = user.usernameToDisplay()
        }

        specialButtons.forEach { (button) in
            button.setTitle(titleButtons[button.tag].localized(), for: .normal)
        }
    }
}
