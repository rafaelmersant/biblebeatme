//
//  ScoresViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/31/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!

    @IBOutlet weak var dateHeader: UILabel!
    @IBOutlet weak var rightsHeader: UILabel!
    @IBOutlet weak var wrongsHeader: UILabel!
    @IBOutlet weak var whoHeader: UILabel!
    @IBOutlet weak var timeHeader: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        //title header formats
        dateHeader.textColor    = mainColor
        rightsHeader.textColor  = mainColor
        wrongsHeader.textColor  = mainColor
        whoHeader.textColor     = mainColor
        timeHeader.textColor    = mainColor

        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30.0, color: mainColor)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)

    }
}


//MARK: ScoreCell

class ScoreCell: UITableViewCell {

    @IBOutlet weak var dateInfo: UILabel!
    @IBOutlet weak var rightsInfo: UILabel!
    @IBOutlet weak var wrongsInfo: UILabel!
    @IBOutlet weak var whoInfo: UILabel!
    @IBOutlet weak var timeInfo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

    }
}
