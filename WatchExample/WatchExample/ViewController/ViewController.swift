//
//  ViewController.swift
//  WatchExample
//
//  Created by patricia.neri on 05/12/18.
//  Copyright © 2018 Livelo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        startSession()
    }

    @IBAction func goToWatch(_ sender: Any) {
        sendMessage(message: ["message" : "Tapped in APP"])
    }


    @IBAction func sendNotification(_ sender: Any) {
        sendNotification()
    }
}
