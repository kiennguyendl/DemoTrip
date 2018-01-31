//
//  CalendarProtocols.swift
//  DemoFaceTrip
//
//  Created by Kiên Nguyễn on 10/31/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import Foundation

protocol CalendarViewDataSource {
    func startDate() -> Date
    func endDate() -> Date
}

extension CalendarViewDataSource {
    
    func startDate() -> Date {
        return Date()
    }
    func endDate() -> Date {
        return Date()
    }
}

protocol CalendarViewDelegate {
    
    /* optional */ //func calendar(canSelectDate date : Date) -> Bool
    //func calendar(didScrollToMonth date : Date) -> Void
    //func calendar(didSelectDate date : Date, withEvents events: [CalendarEvent]) -> Void
    /* optional */ //func calendar(didDeselectDate date : Date) -> Void
}

extension CalendarViewDelegate {
    func calendar(canSelectDate date : Date) -> Bool { return true }
    //func calendar(didDeselectDate date : Date) -> Void { return }
}
