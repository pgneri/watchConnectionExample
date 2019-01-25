//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by patricia.neri on 24/01/19.
//  Copyright © 2019 Livelo. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var attemptContent: UNMutableNotificationContent?
    private lazy var urlSession: URLSession = URLSession()

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        attemptContent = (notification.request.content.mutableCopy() as? UNMutableNotificationContent)

        self.subtitle?.text = attemptContent?.subtitle
        self.label?.text = attemptContent?.body

        let attachment = attemptContent?.attachments[0]
        guard let url: URL = attachment?.url,
              let data = try? Data(contentsOf: url) else {
            return
        }

        DispatchQueue.main.async() {
            self.image.image = UIImage(data: data)
        }

    }
}
