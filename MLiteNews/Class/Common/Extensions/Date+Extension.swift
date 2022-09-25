//
//  Date+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation

extension Date {
    func toFormattedDate(dateFormat: DateFormat = .defaultFormat, isLocaleTime: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        let value: DateFormat = dateFormat
        dateFormatter.dateFormat = value.rawValue
        dateFormatter.locale = Locale(identifier: "ID")
        if isLocaleTime {
            dateFormatter.timeZone = .init(abbreviation: "GMT+7")
        }
        
        return dateFormatter.string(from: self)
    }

}

enum DateFormat: String {
    case defaultFormat = "EEEE, dd MMM yyyy, HH:mm"
}
