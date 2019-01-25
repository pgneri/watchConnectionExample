//
//  NotificationService.swift
//  NotificationService
//
//  Created by patricia.neri on 24/01/19.
//  Copyright © 2019 Livelo. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var attemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        attemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let attemptContent = attemptContent {
            // Modify the notification content here...
            attemptContent.title = "\(attemptContent.title) [modified]"
            
            contentHandler(attemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let attemptContent = attemptContent {
            contentHandler(attemptContent)
        }
    }

}
