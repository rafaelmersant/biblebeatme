//
//  OpponentsViewController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/25/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class OpponentsViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var searchOpponentTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Delegate and DataSource
extension OpponentsViewController: UITableViewDelegate, UITableViewDataSource {

    //DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "opponentCell", for: indexPath)

        return cell
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

}
