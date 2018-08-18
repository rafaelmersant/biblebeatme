//
//  QuestionsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/14/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftDate

class QuestionsViewController : UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var titleApp                     : UILabel!
    @IBOutlet weak var heartsView                   : UIView!
    @IBOutlet weak var headerView                   : UIView!
    @IBOutlet weak var answerStackView              : UIStackView!
    @IBOutlet var mainView                          : UIView!
    @IBOutlet weak var timeElapse                   : UILabel!

    @IBOutlet weak var backButton                   : UIBarButtonItem!
    @IBOutlet weak var answerSection                : UIView!

    @IBOutlet weak var questionLabel                : UILabel!
    @IBOutlet var answerButtons                     : [UIButton]!

    @IBOutlet weak var questionsInfoCount           : UIBarButtonItem!
    @IBOutlet weak var answerButtonsStackView       : UIStackView!
    @IBOutlet weak var answerButtonsStackViewHeight : NSLayoutConstraint!

    fileprivate weak var controller                 : UIViewController?
    
    //Hearts
    @IBOutlet weak var heart1                       : UILabel!
    @IBOutlet weak var heart2                       : UILabel!
    @IBOutlet weak var heart3                       : UILabel!

    //Variables
    fileprivate var answerButtonsStackViewHeightFixed: CGFloat = 0
    fileprivate var questionsSelected               = [Question.QuestionModel]()
    fileprivate var questionNumber                  : Int = -1
    fileprivate var game                            = Game()
    fileprivate var startGameDate                   = Date()
    fileprivate let dbGameCount                     : Int = 0

    fileprivate let of                              = "of".localized()

    //Timer
    var timer = Timer()
    var seconds = 0

    //Animate QuestionText
    fileprivate var startValue                      : Int = 0
    fileprivate var endValue                        : Int = 0
    fileprivate let animationDuration               : Double = 2.0
    fileprivate var startTimeAnimation              : Date!
    fileprivate var questionTextAnimation           : NSString?

    //Subtract heart (if > 3 game over)
    fileprivate var hearts: Int = 3 {
        didSet {
            if oldValue > hearts {
                if let heart = self.view.viewWithTag(1000 * oldValue) as? UILabel {
                    heart.textColor = UIColor.gray
                }
            }

            if hearts == 0 {
                self.terminateGame()
            }
        }
    }

    //MARK: Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Elapsed time: \(startGameDate.timeIntervalSinceNow) seconds")

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
            backButton.title = "Cancel"
            backButton.setTitleTextAttributes([
                NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 17.0)!,
                NSAttributedStringKey.foregroundColor: mainColor], for: .normal)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        questionsToShow()
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
    @IBAction func backToHome(_ sender: UIBarButtonItem?) {
        self.dismiss(animated: true, completion: nil)
    }

    //When user responses a question
    @IBAction func selectAnswer(_ sender: UIButton) {

        self.lock()

        if questionNumber < questionsSelected.count {

            if let answerSelected = questionsSelected[questionNumber].answers?[sender.tag] {

                UIView.animate(withDuration: 0.4, animations: {

                    if answerSelected.isRight == false {
                        sender.backgroundColor = UIColor.red
                        self.hearts -= 1

                    } else {
                        sender.backgroundColor = UIColor.green
                    }

                    sender.setTitleColor(UIColor.black, for: .normal)

                }) { (finished) in

                    UIView.animate(withDuration: 0.3, animations: {

                        self.questionLabel.layer.opacity = 0
                        self.answerButtons.forEach{$0.layer.opacity = 0}

                        self.view.layoutIfNeeded()

                    }, completion: { (finished) in
                        self.refreshAnswerButtons()
                        self.showQuestionOnScreen()
                    })
                }

                answeredSelected(question: questionsSelected[questionNumber], answer: answerSelected)
            }
        }
    }


    //MARK: Functions
    @objc func clock() {
        let elapsed = (Date() - startGameDate)
        let (_, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: Int(elapsed))

        timeElapse.text = "\(minutes):\(seconds) time elapsed"
    }

    //Animate QuestionText at the show moment.
    @objc func animateQuestionText() {

        let now = Date()
        let elapsedTime = now.timeIntervalSince(startTimeAnimation)

        if elapsedTime > animationDuration {
            questionLabel.text = questionTextAnimation?.substring(from: 0)
        } else {
            let percentage = elapsedTime / animationDuration
            let value = percentage * Double(endValue - startValue)
            questionLabel.text = questionTextAnimation!.substring(with: NSRange(location: 0, length: Int(value)))
        }
    }

    func throwQuestionAnimation() {

        let displayLink = CADisplayLink(target: self, selector: #selector(animateQuestionText))
        displayLink.add(to: .main, forMode: .defaultRunLoopMode)

        if let length = questionTextAnimation?.length {
            endValue = length
            startTimeAnimation = Date()
        }
    }

    //Lock screen
    func lock() {
        self.view.isUserInteractionEnabled = false
    }

    //Unlock screen
    func unlock() {
        self.view.isUserInteractionEnabled = true
    }

    //Terminate game
    func terminateGame() {

        Game.end(status: Game.StatusGame.completed)
        self.performSegue(withIdentifier: "showResultsSegue", sender: self)
    }

    //Resize buttons - refresh on UI
    func refreshAnswerButtons() {

        answerButtonsStackViewHeight = answerButtonsStackViewHeight.setMultiplier(multiplier: answerButtonsStackViewHeightFixed)

        //Set border to buttons
        answerButtons.forEach { (button) in
            button.backgroundColor = UIColor(white: 0, alpha: 0.5)
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

        self.unlock()

        //The last question answered
        if questionNumber == questionsSelected.count {
            terminateGame()

        } else {
            //refresh current question number and how many are left.
            questionsInfoCount.title = "\(questionNumber + 1) \(of) \(questionsSelected.count)"
        }

        if questionNumber < questionsSelected.count {

            self.answerButtons.forEach{$0.isHidden = true}

            guard let answersCount = questionsSelected[questionNumber].answers?.count else {
                return
            }

            let orderAnswersRandom = randomArrayOrder(min: 0, max: answersCount, limit: answersCount)

            //Show question text and answers
            if BibleBeatMe.language == "en" {
                questionTextAnimation = questionsSelected[self.questionNumber].questionText_en! as NSString //self.questionLabel.text = questionsSelected[self.questionNumber].questionText_en
            } else {
                questionTextAnimation = questionsSelected[self.questionNumber].questionText_es! as NSString //self.questionLabel.text = questionsSelected[self.questionNumber].questionText_es
            }

            throwQuestionAnimation()

            questionsSelected[self.questionNumber].answers?.forEach({ (answer) in

                if BibleBeatMe.language == "en" {
                    self.answerButtons[orderAnswersRandom[answer.id]].setTitle(answer.text_en, for: .normal)
                } else {
                    self.answerButtons[orderAnswersRandom[answer.id]].setTitle(answer.text_es, for: .normal)
                }

                self.answerButtons[orderAnswersRandom[answer.id]].tag = answer.id
                self.answerButtons[orderAnswersRandom[answer.id]].isHidden = false
            })

            self.refreshAnswerButtons()

            UIView.animate(withDuration: 0.4, animations: {

                self.questionLabel.layer.opacity = 1
                self.answerButtons.forEach{$0.layer.opacity = 1}
            })
        }
    }

    //get questions from DB
    func questionsToShow() {

        var hud: MBProgressHUD!

        if Reachability.isConnectedToNetwork() != true {

            print("There's no internet conection")
            backToHome(nil)

        } else {

            guard let window = self.view.window else {
                print("the view already detached from view hierarchy.")
                return
            }

            hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.animationType = .zoomOut
            hud.contentColor = backColor
            hud.bezelView.color = mainColor
            hud.bezelView.style = .solidColor
            hud.label.text = "Wait"
            hud.detailsLabel.text = "Loading your game..."
        }

        Question.questionsToShow(completion: { (questions) in

            defer {
                hud.hide(animated: true)
            }

            guard let questions = questions else {
                print("There was a problem trying to get questions from Database.")
                return
            }

            self.questionsSelected = questions
            self.showQuestionOnScreen()

            self.prepareGame(questions: questions)
        })
    }

    //Success getting questions started
    func prepareGame(questions: [Question.QuestionModel]) {

        //Start time
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuestionsViewController.clock), userInfo: nil, repeats: true)

        //Initialize game
        Game.start(competitionId: BibleBeatMe.game?.competitionId)

        var questionsId = [Int]()

        questions.forEach { (q) in
            if let id = q.questionId {
                questionsId.append(id)
            }
        }

        Game.questionsForGame(questions: questionsId)
    }

    //When user select an answer
    func answeredSelected(question: Question.QuestionModel, answer: Question.QuestionModel.Answer) {

        if let id = question.questionId {
            Game.answerQuestion(questionId: id, right: answer.isRight)
        }

        print("question : \(question)")
        print("answer : \(answer)")
    }
}
