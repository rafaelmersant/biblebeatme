//
//  QuestionsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class QuestionsViewController : UIViewController {

    @IBOutlet weak var titleApp: UILabel!
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

    fileprivate weak var controller: UIViewController?
    
    //Hearts
    @IBOutlet weak var heart1: UILabel!
    @IBOutlet weak var heart2: UILabel!
    @IBOutlet weak var heart3: UILabel!

    //Variables
    fileprivate var answerButtonsStackViewHeightFixed: CGFloat = 0
    fileprivate var questionsSelected: [Question]?
    fileprivate var questionNumber: Int = -1


    //MARK: Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        questions()

        self.answerButtonsStackViewHeightFixed = answerButtonsStackViewHeight.multiplier

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
        titleApp.textColor = mainColor

        //Hearts sets
        heart1.setIcon(icon: .googleMaterialDesign(.favorite), iconSize: 30, color: UIColor.red)
        heart1.sizeToFit()
        heart2.setIcon(icon: .googleMaterialDesign(.favorite), iconSize: 30, color: UIColor.red)
        heart2.sizeToFit()
        heart3.setIcon(icon: .googleMaterialDesign(.favorite), iconSize: 30, color: UIColor.red)
        heart3.sizeToFit()

        // add right navigation bar button items.
        do {

            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30, color: mainColor)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showResultsSegue" {

            if let navigationController = segue.destination as? UINavigationController {
                self.controller = navigationController
                if let destination = navigationController.viewControllers.first as? ResultsViewController {

                    //destination.opponent = self.opponentSelected!
                }
            }
        }
    }

    //MARK: IBActions
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func selectAnswer(_ sender: UIButton) {

        if let questionsAll = questionsSelected?.count, questionNumber < questionsAll  {

            if let answerSelected = questionsSelected?[questionNumber].answers?[sender.tag] {

                print("Answer Selected : \(answerSelected)")
                showQuestionOnScreen()
            }
        }

        //The last question answered
        if questionNumber == questionsSelected?.count {

            self.performSegue(withIdentifier: "showResultsSegue", sender: self)
        }
    }


    //MARK: Functions

    //Resize buttons - refresh on UI
    func refreshAnswerButtons() {

        answerButtonsStackViewHeight = answerButtonsStackViewHeight.setMultiplier(multiplier: answerButtonsStackViewHeightFixed)

        //Set border to buttons
        answerButtons.forEach { (button) in
            button.layer.borderColor = UIColor.gray.cgColor
            button.setTitleColor(mainColor, for: .normal)

            if button.isHidden == true {

                let multiplier = (answerButtonsStackViewHeight.multiplier - 0.24)
                answerButtonsStackViewHeight = answerButtonsStackViewHeight.setMultiplier(multiplier: multiplier)

            }
        }
    }

    //Show each question in front
    func showQuestionOnScreen() {

        questionNumber += 1

        if let questionsSelected = questionsSelected, questionNumber < questionsSelected.count {

            self.questionLabel.text = questionsSelected[questionNumber].questionText

            self.answerButtons.forEach{$0.isHidden = true}

            guard let answersCount = questionsSelected[questionNumber].answers?.count else {
                return
            }

            var orderAnswers = [Int]()

            while(orderAnswers.count < answersCount) {

                let index = randomNumber(min: 0, max: answersCount)

                if !orderAnswers.contains( Int(index) ) {
                    orderAnswers.append( Int(index) )
                }
            }

            questionsSelected[questionNumber].answers?.forEach({ (A) in

                self.answerButtons[orderAnswers[A.id]].setTitle(A.text, for: .normal)
                self.answerButtons[orderAnswers[A.id]].tag = A.id
                self.answerButtons[orderAnswers[A.id]].isHidden = false
            })
        }

        refreshAnswerButtons()
    }

    //get questions from DB
    func questions() {

        Database.database().reference().child(questionsModel).observeSingleEvent(of: .value, with: { (snapshot) in

            guard let value = snapshot.value else { return }

            do {
                let questions = try FirebaseDecoder().decode([Question].self, from: value)

                self.questionsSelected = questions.filter({ (Q) -> Bool in
                    return Q.isActive == true
                })

                self.showQuestionOnScreen()

            } catch let error {
                print(error)
            }
        })
    }

}
