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

    @IBOutlet weak var dateHeader       : UILabel!
    @IBOutlet weak var rightsHeader     : UILabel!
    @IBOutlet weak var wrongsHeader     : UILabel!
    @IBOutlet weak var whoHeader        : UILabel!
    @IBOutlet weak var timeHeader       : UILabel!
    @IBOutlet weak var tableView        : UITableView!
    @IBOutlet var mainView              : UIView!
    @IBOutlet weak var headerTableView  : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set backColor
        mainView.backgroundColor = backColor
        headerTableView.backgroundColor = backColor

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

//MARK: Delegate and DataSource
extension ScoresViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "scoreCell", for: indexPath) as? ScoreCell

        //Set backColor
        cell?.dateInfo.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.rightsInfo.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.wrongsInfo.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.whoInfo.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.timeInfo.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.backgroundColor = backColor

        cell?.dateInfo.text = "May 2, 2018"
        cell?.rightsInfo.text = "9"
        cell?.wrongsInfo.text = "3"
        cell?.whoInfo.text = "Pedro432"
        cell?.timeInfo.text = "1:15"

        return cell!
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    //MARK: Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //self.opponentSelected = opponents[indexPath.row]
        //self.performSegue(withIdentifier: "showOpponent", sender: self)

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
