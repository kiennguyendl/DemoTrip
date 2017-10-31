//
//  CalendarExtension.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/30/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation
import UIKit
import EventKit

extension EKEvent {
    var isOneDay : Bool {
        let components = Calendar.current.dateComponents([.era, .year, .month, .day], from: self.startDate, to: self.endDate)
        print("components: \(components)")
        return (components.era == 0 && components.year == 0 && components.month == 0 && components.day == 0)
    }
}

extension String {
    
    subscript(_ range: CountableRange<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        let subString = self[start..<end]
        return String(subString)
    }
    
}
