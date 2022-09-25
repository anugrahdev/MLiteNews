//
//  UILabel+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation
import UIKit

extension UILabel {
    func makeLabelShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
}
