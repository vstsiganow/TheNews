//
//  Date+Extension.swift
//  TheNews
//
//  Created by vtsyganov on 22.02.2022.
//

import Foundation

extension Date {
    func toString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func intervalComponents(to secondDate: Date, calendar: Calendar = .current, calendarComponent: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]) -> DateComponents {
        return calendar.dateComponents(calendarComponent, from: self, to: secondDate)
    }
    

}
