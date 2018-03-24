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

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set border to buttons
        resultsButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
