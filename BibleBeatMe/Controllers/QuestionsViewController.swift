//
//  QuestionsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class QuestionsViewController : UIViewController {

    @IBOutlet weak var heartsView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var timeElapse: UILabel!

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var answerSection: UIView!

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!

    @IBOutlet weak var answerButtonsStackView: UIStackView!
    @IBOutlet weak var answerButtonsStackViewHeight: NSLayoutConstraint!
    
    //Hearts
    @IBOutlet weak var heart1: UILabel!
    @IBOutlet weak var heart2: UILabel!
    @IBOutlet weak var heart3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden        = false
        self.navigationController?.navigationBar.barTintColor   = UIColor.black
        self.navigationController?.navigationBar.barStyle       = .black

        //Set backColor
        heartsView.backgroundColor = backColor
        headerView.backgroundColor = backColor
        questionLabel.backgroundColor = backColor
        questionLabel.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        timeElapse.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        answerStackView.backgroundColor = backColor
        mainView.backgroundColor = backColor

        //Hearts sets
        heart1.setIcon(icon: .googleMaterialDesign(.favorite), iconSize: 30, color: UIColor.gray)
        heart1.sizeToFit()
        heart2.setIcon(icon: .googleMaterialDesign(.favorite), iconSize: 30, color: UIColor.red)
        heart2.sizeToFit()
        heart3.setIcon(icon: .googleMaterialDesign(.favorite), iconSize: 30, color: UIColor.red)
        heart3.sizeToFit()

        //Set border to buttons
        answerButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(mainColor, for: .normal)

            if button.tag == 1100 || button.tag == 1200 {
                button.isHidden = true

                let multiplier = (answerButtonsStackViewHeight.multiplier - 0.24)
                answerButtonsStackViewHeight = answerButtonsStackViewHeight.setMultiplier(multiplier: multiplier)
            }
        }

        print("Font Size Principal:::: \(questionLabel.font.pointSize)")

        // add right navigation bar button items.
        do {
//            var barButtonItems = [UIBarButtonItem]()
//            if let button = Bundle.main.loadNibNamed("NavigationBarButton", owner: nil, options: nil)?.first as? UIButton {
//                button.titleLabel?.text = ""
//                button.setIcon(prefixText: "", icon: .googleMaterialDesign(.arrowBack), postfixText: "", forState: .normal)

//                button.addTarget(self, action: #selector(SearchViewController.logout(_:)), for: .touchUpInside)

                backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30, color: mainColor)

//                barButtonItems.append(UIBarButtonItem(customView: backButton))
            }
//
//            if let button = Bundle.main.loadNibNamed("NavigationBarButton", owner: nil, options: nil)?.first as? PCButton {
//                button.type = PCButton.NavigationBarItemSetting
//                button.addTarget(self, action: #selector(SearchViewController.tappedSetting(_:)), for: .touchUpInside)
//                barButtonItems.append(UIBarButtonItem(customView: button))
//            }

            //self.navigationItem.rightBarButtonItems = barButtonItems
       // }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    //MARK: IBActions
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
