//
//  ScheduleDate.swift
//  TestTaskAlarm
//
//  Created by Мак on 12/6/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit
import UserNotifications
class ScheduleNotification {
    private init(){}
    static let shared = ScheduleNotification()
    
    let notificationCenter = UNUserNotificationCenter.current()
    func scheduleNotification(notifaicationType: String, date: Date) {
        
        
        let content = UNMutableNotificationContent()
        
        content.title = notifaicationType
        content.body = ""
        content.sound = UNNotificationSound.defaultCritical
        
        content.badge = 0
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        let identifire = "Local Notification"
        let request = UNNotificationRequest(identifier: identifire,
                                            content: content,
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
    }
    
}
