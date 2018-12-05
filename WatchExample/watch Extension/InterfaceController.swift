//
//  InterfaceController.swift
//  watch Extension
//
//  Created by patricia.neri on 05/12/18.
//  Copyright © 2018 Livelo. All rights reserved.
//

import WatchKit
import WatchConnectivity

class InterfaceController: WKInterfaceController {

    @IBOutlet var label: WKInterfaceLabel!

    let session = WCSession.default

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        startSession()
    }

    func startSession(){
        if WCSession.isSupported(){
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func goToiPhone() {
        sendMessage(message: ["message" : "Tapped in WATCH"])
    }

    func sendMessage(message: [String : Any]) {
        session.sendMessage(message, replyHandler: { response in
            if let responseMessage = response["message"] as? String {
                DispatchQueue.main.async {
                    self.label.setText(responseMessage)
                }
            } else {
                print(response)
            }
        }, errorHandler: { erro in
            print(erro)
        })
    }
}

extension InterfaceController: WCSessionDelegate {

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("actived")
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {

        if let message = message["message"] as? String {

            DispatchQueue.main.async {
                self.label.setText(message)
            }

            let messageCallback = ["message": "Changed in Watch"]
            replyHandler(messageCallback)
        } else {
            print(message)
        }
    }
}
