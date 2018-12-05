//
//  ViewController.swift
//  WatchExample
//
//  Created by patricia.neri on 05/12/18.
//  Copyright © 2018 Livelo. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!

    let session = WCSession.default

    override func viewDidLoad() {
        super.viewDidLoad()

        startSession()
    }

    func startSession(){
        if WCSession.isSupported(){
            session.delegate = self
            session.activate()
        }
    }

    @IBAction func goToWatch(_ sender: Any) {
        sendMessage(message: ["message" : "Tapped in APP"])
    }

    func sendMessage(message: [String : Any])                                                                              {
        session.sendMessage(message, replyHandler: { response in
            if let responseMessage = response["message"] as? String {
                DispatchQueue.main.async {
                    self.label.text = responseMessage
                }
            } else {
                print(response)
            }
        }, errorHandler: { erro in
            print(erro)
        })
    }
}

extension ViewController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationState")
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }

    func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {

        if let message = message["message"] as? String {
            DispatchQueue.main.async {
                self.label.text = message
            }
            let messageCallback = ["message": "Changed in APP"]

            replyHandler(messageCallback)
        } else {
            print(message)
        }
    }
}

