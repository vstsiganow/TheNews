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
    
    func time(to secondDate: Date, calendar: Calendar = .current, calendarComponent: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]) -> DateComponents {
        return calendar.dateComponents(calendarComponent, from: self, to: secondDate)
    }
    
    func dateDifference(to secondDate: Date, calendar: Calendar = .current, calendarComponent: Calendar.Component = .minute) -> (Calendar.Component, Int) {
        let dateComponents = calendar.dateComponents([calendarComponent], from: self, to: secondDate)

        guard let value = dateComponents.value(for: calendarComponent) else { return ( calendarComponent, 0 ) }
        
        return (calendarComponent, value)
    }
}
