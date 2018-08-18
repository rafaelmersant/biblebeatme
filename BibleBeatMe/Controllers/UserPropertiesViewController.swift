//
//  UserPropertiesViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 5/16/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

let maxUserNameLength = 15

class UserPropertiesViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var message: UILabel!

    @IBOutlet weak var segmentedLanguage: UISegmentedControl!

    let languages = ["en", "es"]

    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self

        message.isHidden = true

        segmentedLanguage.selectedSegmentIndex = languages.index(where: { (language) -> Bool in
            return language == BibleBeatMe.language
        })!

        if let user = BibleBeatMe.user, user.userName != "" {
            userNameTextField.text = user.usernameToDisplay()
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {

        if let user = BibleBeatMe.user, let userName = userNameTextField.text {

            User.userExist(userName: userName) { (found) in

                if found == true && userName != "" && userName != BibleBeatMe.user?.userName {

                    self.message.isHidden = false

                } else {

                    BibleBeatMe.user?.userName = userName
                    User.updateUserName()

                    print("the user was updated: \(user.userGuestId) with name: \(user.userName)")

                    // post notification for refreshing userName.
                    let notificationCenter = NotificationCenter.default
                    notificationCenter.post(name: Notification.Name(rawValue: "refreshUserName"), object: self)

                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func languageSelected(_ sender: UISegmentedControl) {
        setDefaultLanguage(new: languages[sender.selectedSegmentIndex])
    }
}

//MARK: UITextFieldDelegate
extension UserPropertiesViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let expectedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if expectedString.count > maxUserNameLength {
            return false
        } else {
            return true
        }
    }
}
