//
//  DareViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/31/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class DareViewController: UIViewController {

    @IBOutlet weak var backButton       : UIBarButtonItem!
    @IBOutlet weak var acceptButton     : UIButton!
    @IBOutlet weak var rejectButton     : UIButton!
    @IBOutlet weak var opponentName     : UILabel!
    @IBOutlet weak var textInvitation   : UILabel!
    @IBOutlet weak var timeElapsed      : UILabel!
    @IBOutlet var mainView              : UIView!
    @IBOutlet weak var seeMoreButton    : UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set backColor
        mainView.backgroundColor = backColor
        textInvitation.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        timeElapsed.textColor = backColor == UIColor.white ? UIColor.black : hexToUIColor(hexString: "FF9900") //UIColor.white

        //Buttons formats
        acceptButton.layer.borderColor = UIColor.gray.cgColor
        acceptButton.setTitleColor(mainColor, for: .normal)
        rejectButton.layer.borderColor = UIColor.gray.cgColor
        rejectButton.setTitleColor(mainColor, for: .normal)

        //text formats
        opponentName.textColor = mainColor

        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30.0, color: mainColor)
            seeMoreButton.setIcon(icon: .googleMaterialDesign(.more), iconSize: 30.0, color: mainColor)
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
