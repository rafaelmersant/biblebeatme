//
//  DareViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/31/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class DareViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var textInvitation: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Buttons formats
        acceptButton.layer.borderColor = UIColor.gray.cgColor
        acceptButton.setTitleColor(mainColor, for: .normal)
        rejectButton.layer.borderColor = UIColor.gray.cgColor
        rejectButton.setTitleColor(mainColor, for: .normal)

        //text formats
        opponentName.textColor = mainColor

        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30.0, color: mainColor)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: IBAction methods

    @IBAction func backToOpponents(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)

    }

}
