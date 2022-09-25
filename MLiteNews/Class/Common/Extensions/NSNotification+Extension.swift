//
//  NSNotification+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation

extension NSNotification.Name {
    
    enum NotificationName: String {
        case offline = "Navigation.offline"
    }
    
    static func getNotification(with name: NotificationName) -> NSNotification.Name {
        return .init(name.rawValue)
    }
}
