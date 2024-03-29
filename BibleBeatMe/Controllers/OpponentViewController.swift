//
//  OpponentViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/26/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class OpponentViewController: UIViewController {

    var opponent: User.UserModel?

    //MARK: IBOutlets
    @IBOutlet weak var opponentName     : UILabel!
    @IBOutlet weak var backButton       : UIBarButtonItem!
    @IBOutlet weak var contentView      : UIView!
    @IBOutlet weak var dareButton       : UIButton!
    @IBOutlet weak var infoButton       : UILabel!
    @IBOutlet weak var responseLabel    : UILabel!
    @IBOutlet weak var opponentNameView : UIView!

    //MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set backColor
        contentView.backgroundColor = backColor
        opponentNameView.backgroundColor = backColor
        responseLabel.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white

        //Opponent Name formats
        opponentName.textColor = mainColor

        //Dare Button formats
        dareButton.layer.borderColor = UIColor.gray.cgColor
        dareButton.setTitleColor(mainColor, for: .normal)

        //InfoButton
        infoButton.setIcon(icon: .googleMaterialDesign(.infoOutline), iconSize: 30.0, color: mainColor)

        if let opponent = opponent {
            opponentName.text = opponent.usernameToDisplay()
        }

        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30.0, color: mainColor)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: IBActions methods
    @IBAction func backToOpponents(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
