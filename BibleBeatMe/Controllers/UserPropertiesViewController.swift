//
//  UserPropertiesViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 5/16/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class UserPropertiesViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        message.isHidden = true

        if let user = BibleBeatMe.user {
            userNameTextField.text = user.usernameToDisplay()
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {

        if let user = BibleBeatMe.user {
            BibleBeatMe.user?.userName = userNameTextField.text!
            BibleBeatMe.User.updateUserName()

            print("the user was updated: \(user.userGuestId) with name: \(user.userName)")

            // post notification for refreshing userName.
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: Notification.Name(rawValue: "refreshUserName"), object: self)

            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
