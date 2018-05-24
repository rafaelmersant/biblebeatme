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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameTextField.delegate = self

        message.isHidden = true

        if let user = BibleBeatMe.user, user.userName != "" {
            userNameTextField.text = user.usernameToDisplay()
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {

        if let user = BibleBeatMe.user, let userName = userNameTextField.text {

            BibleBeatMe.User.userExist(userName: userName) { (found) in

                if found == true && userName != "" {

                    self.message.isHidden = false

                } else {

                    BibleBeatMe.user?.userName = userName
                    BibleBeatMe.User.updateUserName()

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
