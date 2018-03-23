//
//  QuestionsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class QuestionsViewController : UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var answerSection: UIView!
    @IBOutlet weak var questionSection: UIView!

    @IBOutlet var answerButtons: [UIButton]!

    @IBOutlet weak var answerButtonsStackView: UIStackView!
    //Hearts
    @IBOutlet weak var heart1: UILabel!
    @IBOutlet weak var heart2: UILabel!
    @IBOutlet weak var heart3: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden        = false
        self.navigationController?.navigationBar.barTintColor   = UIColor.black
        self.navigationController?.navigationBar.barStyle       = .black

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

//            if button.tag == 200  {
//                button.isHidden = true
//            }
        }
        
//        let option = UIButton(frame: CGRect(x: 10, y: 10, width: 226, height: 57))
//        option.setTitle("Mateo 7:1", for: .normal)
//        option.setTitleColor(mainColor, for: .normal)
//        option.backgroundColor = UIColor.black
//        option.layer.borderWidth = 1
//        option.layer.borderColor = UIColor.gray.cgColor
//        option.translatesAutoresizingMaskIntoConstraints = false
//
//        answerSection.addSubview(option)

//        answerSection.backgroundColor = UIColor.gray

        //NSLayoutConstraints
//        let horizontalConstraintOption =
//            NSLayoutConstraint(item: option,
//                               attribute: .centerX,
//                               relatedBy: .equal,
//                               toItem: answerSection,
//                               attribute: .centerX,
//                               multiplier: 1,
//                               constant: 0)
//
//        let verticalConstraintOption =
//            NSLayoutConstraint(item: option,
//                               attribute: .top,
//                               relatedBy: .equal,
//                               toItem: answerSection,
//                               attribute: .top,
//                               multiplier: 1,
//                               constant: 0)
//
//        let heightConstraintOption =
//            NSLayoutConstraint(item: option,
//                               attribute: .height,
//                               relatedBy: .equal,
//                               toItem: nil,
//                               attribute: .height,
//                               multiplier: 1,
//                               constant: 40)
//
//        let widthConstraintOption =
//            NSLayoutConstraint(item: option,
//                               attribute: .width,
//                               relatedBy: .equal,
//                               toItem: nil,
//                               attribute: .width,
//                               multiplier: 1,
//                               constant: 150)
//
//        answerSection.addConstraint(horizontalConstraintOption)
//        answerSection.addConstraint(verticalConstraintOption)
//        answerSection.addConstraint(heightConstraintOption)
//        answerSection.addConstraint(widthConstraintOption)


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
}
