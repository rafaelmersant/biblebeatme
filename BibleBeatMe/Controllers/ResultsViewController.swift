//
//  ResultsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/23/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var resultsButtons        : [UIButton]!
    @IBOutlet weak var homeButton       : UIBarButtonItem!
    @IBOutlet weak var resultsLabel     : UILabel!
    @IBOutlet weak var contentView      : UIView!
    @IBOutlet weak var messageResult    : UILabel!
    @IBOutlet var mainView              : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set backColor
        mainView.backgroundColor = backColor
        resultsLabel.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        contentView.backgroundColor = backColor
        messageResult.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white

        //Set border to buttons
        resultsButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(mainColor, for: .normal)
        }

        //Home button
        homeButton.setIcon(icon: .ionicons(.iosHome), iconSize: 30.0, color: mainColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goToHome(_ sender: UIBarButtonItem) {
       // self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
}
