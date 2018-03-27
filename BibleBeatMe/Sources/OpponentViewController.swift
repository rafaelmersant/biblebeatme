//
//  OpponentViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/26/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class OpponentViewController: UIViewController {

    var opponent: String?

    //MARK: IBOutlets
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var contentView: UIView!
    
    //MARK: Overrides methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let opponent = opponent {
            opponentName.text = opponent
        }

        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30, color: mainColor)
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
