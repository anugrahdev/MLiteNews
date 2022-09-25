//
//  String+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

extension String {
    var initials: String {
        return self.components(separatedBy: " ").map { String($0.prefix(1))}.joined()
    }
    
    func toDate(stampFormat: TimestampFormat = .defaultStamp) -> Date? {
        let dateFormatter = DateFormatter()
        let timestamp = stampFormat.rawValue
        dateFormatter.dateFormat = timestamp
        dateFormatter.timeZone = .init(secondsFromGMT: 0)
        return dateFormatter.date(from: self)
    }
}

enum TimestampFormat: String {
    case defaultStamp = "yyyy-MM-dd'T'HH:mm:ss'Z'"
}
