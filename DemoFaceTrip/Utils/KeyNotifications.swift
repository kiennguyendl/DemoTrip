//
//  KeyNotifications.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 11/2/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation

//indentifier notification center
let notificationCenter = NotificationCenter.default

//using for calendar in booking screen
let calendarPushtoBookingNotification   =       Notification.Name(rawValue:"calendarBooking")
let indexPathForCellSelected            =       Notification.Name(rawValue:"indexPathForCellSelected")
let oldIndexPathForCellSelected         =       Notification.Name(rawValue:"oldIndexPathForCellSelected")
let indexPathNotification               =       Notification.Name(rawValue:"indexPathFoMonth")