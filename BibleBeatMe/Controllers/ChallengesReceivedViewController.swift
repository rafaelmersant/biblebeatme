//
//  ChallengesViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 4/4/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class ChallengesReceivedViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30, color: mainColor)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backToOpponents(_ sender: UIBarButtonItem) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
}


//MARK: Delegate and DataSource
extension ChallengesReceivedViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "challengeReceivedCell", for: indexPath) as? ChallengeReceivedCell

        //Set backColor
        cell?.statusDescrp.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.backgroundColor = backColor
        cell?.opponentName.textColor = mainColor

        cell?.opponentName.text = "Rafael996"
        cell?.timeElapsed.text = "15 minutes ago"
        cell?.statusDescrp.text = "Waiting"

        return cell!
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    //MARK: Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}


//MARK: ChallengeReceivedCell

class ChallengeReceivedCell: UITableViewCell {

    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!
    @IBOutlet weak var statusDescrp: UILabel!

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
