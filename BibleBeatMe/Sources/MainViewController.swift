//
//  ViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 1/1/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import SwiftIcons

class MainViewController: UIViewController {

    @IBOutlet var specialButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set border to buttons
        specialButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
}

