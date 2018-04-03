//
//  ModalNavigationController.swift
//  BibleBeatMe
//
//  Created by Rafael Mercedes on 3/18/18.
//  Copyright © 2018 rafaelmersant. All rights reserved.
//

import UIKit

class ModalNavigationController: UINavigationController {

    // MARK: Properties

    fileprivate var offset = CGPoint.zero

    // MARK: Override Methods

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Set color for title in navBar
        let textAttributes = [NSAttributedStringKey.foregroundColor: mainColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes

        //Set color for background in navBar
        UINavigationBar.appearance().barTintColor = backColor
        UINavigationBar.appearance().isTranslucent = false
        
        if let window = self.view.window {
            self.offset.x   = window.center.x - self.view.center.x
            self.offset.y   = window.center.y - self.view.center.y
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Status Bar Style

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

}
