//
//  OpponentsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/25/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class OpponentsViewController: UIViewController {

    let opponents = ["Pedro124", "Rafael443", "Jose884", "Rafaelmersant", "Juan654", "John233", "Guest432","Pedro124", "Rafael443", "Jose884", "Rafaelmersant", "Juan654", "John233", "Guest432"]
    let opponentsStatus = ["Active", "Inactive", "Active", "Active", "Active", "Active", "Inactive", "Active", "Inactive", "Active", "Active", "Active", "Active", "Inactive"]

    public var opponentSelected: String?

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchOpponentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    fileprivate weak var controller: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        searchOpponentTextField.backgroundColor = UIColor.black
        searchOpponentTextField.layer.cornerRadius = 8.0
        searchOpponentTextField.layer.borderWidth = 1
        searchOpponentTextField.layer.borderColor = UIColor.gray.cgColor

        searchOpponentTextField.setLeftViewIcon(icon: .googleMaterialDesign(.search), leftViewMode: .always, textColor: .gray, backgroundColor: .black, size: CGSize(width: 30, height: 30) )
        
        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30, color: mainColor)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }


    //MARK: Override

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showOpponent" {

            if let navigationController = segue.destination as? UINavigationController {
                self.controller = navigationController
                if let destination = navigationController.viewControllers.first as? OpponentViewController {

                    destination.opponent = self.opponentSelected!

//                    destination.user                = self.user
                }
            }

        }
    }


}

//MARK: Delegate and DataSource
extension OpponentsViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "opponentCell", for: indexPath) as? OpponentCell

        cell?.opponentName.text = opponents[indexPath.row]
        cell?.opponentStatus.text = opponentsStatus[indexPath.row]

        return cell!
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return opponents.count
    }

    //MARK: Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.opponentSelected = opponents[indexPath.row]
        self.performSegue(withIdentifier: "showOpponent", sender: self)

    }
}


//MARK: OpponentCell

class OpponentCell: UITableViewCell {

    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var opponentStatus: UILabel!
    
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
