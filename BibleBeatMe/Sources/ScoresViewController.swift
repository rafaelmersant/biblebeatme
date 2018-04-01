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
    override func viewDidLoad() {
        super.viewDidLoad()

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
