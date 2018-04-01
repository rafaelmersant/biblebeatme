//
//  ResultsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/23/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var resultsButtons: [UIButton]!
    @IBOutlet weak var homeButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set border to buttons
        resultsButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
        }

        //Home button
        homeButton.setIcon(icon: .googleMaterialDesign(.home), iconSize: 30.0, color: mainColor)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goToHome(_ sender: UIBarButtonItem) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
    
}
