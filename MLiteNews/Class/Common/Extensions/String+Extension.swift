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
}
