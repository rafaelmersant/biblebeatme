//
//  ResultsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/23/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var titleApp: UILabel!
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
        titleApp.textColor = mainColor

        //Set border to buttons
        resultsButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(mainColor, for: .normal)
        }

        //Home button
        homeButton.setIcon(icon: .ionicons(.iosHome), iconSize: 30.0, color: mainColor)

        //Show results game
        showResults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goToHome(_ sender: UIBarButtonItem) {
       // self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }

    private func showResults() {

        if let game = BibleBeatMe.game {
            resultsButtons[0].setTitle("Rights: \(game.answeredRights.count)", for: .normal)
            resultsButtons[1].setTitle("Wrongs: \(game.answeredWrongs.count)", for: .normal)

            if let questions = game.questions {

                let averageRight = Double((game.answeredRights.count / questions.count) * 100)
                let averageWrong = Double((game.answeredWrongs.count / questions.count) * 100)

                messageResult.text = "Average right: \(averageRight) -- Average Wrong: \(averageWrong)"
                print("Average to give message result: \(averageRight) -- \(averageWrong)")
            }
        }
    }
}
