//
//  UITableView+Extensions.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation
import UIKit

private var activityIndicator: UIActivityIndicatorView?

public extension UITableView {
    
    internal func setEmptyView(title: String) {
        let emptyView = EmptyResultViewBuilder()
            .setEmpty(title)
            .build()
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
 
    // MARK: - Common
    func showLoading() {
        if activityIndicator == nil {
            activityIndicator = createActivityIndicator()
        }
        showSpinning()
    }
    
    func hideLoading() {
        guard let indicator = activityIndicator else { return }
        indicator.stopAnimating()
    }
    
    // MARK: - Activity Indicator
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .lightGray
        return activityIndicator
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        addConstraint(xCenterConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraint(yCenterConstraint)
    }
    
    private func showSpinning() {
        guard let indicator = activityIndicator else { return }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        centerActivityIndicatorInButton()
        indicator.startAnimating()
    }
    
    
}
