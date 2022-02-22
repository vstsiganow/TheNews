//
//  String+Extension.swift
//  TheNews
//
//  Created by vtsyganov on 22.02.2022.
//

import Foundation

extension String {
    func toDate(with format: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = format
        
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
}

// "2022-02-14T17:33:54.000000Z"
