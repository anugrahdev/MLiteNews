//
//  SizeUtils.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

struct SizeUtils {
    
    static let shared = SizeUtils()
    
    let screenHeight: CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    let screenWidth: CGFloat = {
        return UIScreen.main.bounds.width
    }()
}
