//
//  CGFloat+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import Foundation
import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
