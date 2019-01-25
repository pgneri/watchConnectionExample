//
//  ViewController+UserNotification.swift
//  WatchExample
//
//  Created by patricia.neri on 24/01/19.
//  Copyright © 2019 Livelo. All rights reserved.
//

import UIKit
import UserNotifications

extension ViewController {

    func sendNotification() {
        let id = String(Date().timeIntervalSince1970)
        let content = UNMutableNotificationContent()
        content.title = "BLA BLA BLA"
        content.subtitle = "BLA HAHAHA HAHAHA HAHAH"
        content.body = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it."
        content.categoryIdentifier = "customNotification"

        if let url = Bundle.main.url(forResource: "apple-watch-icons", withExtension: "jpg"),
            let attachment = try? UNNotificationAttachment(identifier: "image", url: url, options: [:]) {
            content.attachments = [attachment]
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: id,
                                            content: content,
                                            trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription ?? "not error")
        }
    }
}
