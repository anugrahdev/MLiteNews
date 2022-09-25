//
//  UIView+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

extension UIView {
    
    func makeCircleCorner() {
        layer.cornerRadius = frame.height / 2
    }
    
    func makeCardCorner() {
        layer.cornerRadius = 10
    }
    
    func makeCardShadow(opacity: Float = 0.1) {
        layer.shadowColor = CGColor(red: 30.0 / 255.0, green: 68.0 / 255.0, blue: 92.0 / 255.0, alpha: 1)
        layer.shadowOpacity = opacity
        layer.shadowRadius = 3
        layer.shadowOffset = .init(width: 1, height: 1)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
