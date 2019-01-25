//
//  AppDelegate+UserNotification.swift
//  WatchExample
//
//  Created by patricia.neri on 24/01/19.
//  Copyright © 2019 Livelo. All rights reserved.
//

import UIKit
import UserNotifications

extension AppDelegate {

    // Singleton current UNUserNotificationCenter
    var center: UNUserNotificationCenter {
        return UNUserNotificationCenter.current()
    }

    func configureNotification() {
        center.delegate = self

        // Actions
        let confirmAction = UNNotificationAction(identifier: "confirm", title: "Ok, ta top 👍", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "cancel", title: "sai fora 👊", options: [])

        // Categories
        let category = UNNotificationCategory(identifier: "customNotification",
                                              actions: [confirmAction, cancelAction],
                                              intentIdentifiers: [])

        center.setNotificationCategories([category])

        // Authorizations
        if #available(iOS 12.0, *) {
            center.requestAuthorization(options: [.alert, .badge, .sound, .providesAppNotificationSettings]) { (success, error) in
                print(success)
            }
        } else {
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                print(success)
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
        case "confirm":
            print("confirm: Ok, ta top 👍")
        case "cancel":
            print("cancel: sai fora 👊")
        case UNNotificationDefaultActionIdentifier:
            print("Tocou na notificação")
        case UNNotificationDismissActionIdentifier:
            print("usuário dismissou a notificação")
        default:
            break
        }

        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .badge, .sound])
    }
}
