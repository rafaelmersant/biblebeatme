//
//  OpponentsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/25/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class OpponentsViewController: UIViewController {

    var usersList: [User.UserModel]?

    public var opponentSelected: User.UserModel?

    @IBOutlet weak var headerView               : UIView!
    @IBOutlet weak var backButton               : UIBarButtonItem!
    @IBOutlet weak var searchOpponentTextField  : UITextField!
    @IBOutlet weak var tableView                : UITableView!
    @IBOutlet weak var tableHeaderView          : UIView!
    @IBOutlet weak var titleOpponent            : UILabel!
    @IBOutlet weak var battlesButton            : UIBarButtonItem!

    fileprivate weak var controller             : UIViewController?

    //MARK: Override methods

    override func viewDidLoad() {
        super.viewDidLoad()

        //get users
        users(country: nil) {
            self.tableView.reloadData()
        }

        //Set backColor
        headerView.backgroundColor = backColor
        
        //title opponent formats
        titleOpponent.textColor = mainColor

        //Search Opponent TextField
        searchOpponentTextField.backgroundColor = backColor
        searchOpponentTextField.layer.cornerRadius = 8.0
        searchOpponentTextField.layer.borderWidth = 1
        searchOpponentTextField.layer.borderColor = UIColor.gray.cgColor

        searchOpponentTextField.setLeftViewIcon(
            icon            : .googleMaterialDesign(.search),
            leftViewMode    : .always,
            textColor       : .gray,
            backgroundColor : backColor,
            size            : CGSize(width: 30, height: 30)
        )
        
        do {
            backButton.setIcon(icon: .ionicons(.iosArrowBack), iconSize: 30.0, color: mainColor)
            battlesButton.setIcon(icon: .icofont(.list), iconSize: 30.0, color: mainColor)
        }

        self.tableView.tableHeaderView = self.tableHeaderView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showOpponent" {

            if let navigationController = segue.destination as? UINavigationController {
                self.controller = navigationController
                if let destination = navigationController.viewControllers.first as? OpponentViewController {

                    destination.opponent = self.opponentSelected!
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    //MARK: IBActions

    @IBAction func backToHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: Functions

    fileprivate func users(country: String?, completion: @escaping () -> Void) {
        User.users(country: country) { (usrs) in

            if let users = usrs {
                self.usersList = users.filter({ (user) -> Bool in
                    return user.userName != BibleBeatMe.user?.userName
                })
                completion()
            }
        }
    }
}

//MARK: Delegate and DataSource
extension OpponentsViewController: UITableViewDelegate, UITableViewDataSource {

    //MARK: DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "opponentCell", for: indexPath) as? OpponentCell

        guard let user = usersList?[indexPath.row] else {
            print("The user for position: \(indexPath.row) does not exist.")
            return cell!
        }

        //Set backColor
        cell?.opponentName.textColor = backColor == UIColor.white ? UIColor.black : UIColor.white
        cell?.opponentStatus.textColor = backColor == UIColor.white ? UIColor.black : UIColor.lightGray
        cell?.backgroundColor = backColor

        cell?.opponentName.text = user.usernameToDisplay()

        if user.isOnline == true {
            cell?.opponentStatus.text = "Online"
        } else {
            let lastSeen = Date(timeIntervalSince1970: user.lastSeen)

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = NSCalendar.current.compare(lastSeen, to: Date(), toGranularity: .day) == .orderedSame ? .none : .short
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: BibleBeatMe.language)

            cell?.opponentStatus.text = dateFormatter.string(for: lastSeen as Date)
        }

        return cell!
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList?.count ?? 0
    }

    //MARK: Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        if let opponent = usersList?[indexPath.row] {
            self.opponentSelected = opponent
            self.performSegue(withIdentifier: "showOpponent", sender: self)
        }
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
