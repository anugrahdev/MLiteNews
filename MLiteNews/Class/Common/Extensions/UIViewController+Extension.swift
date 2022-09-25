//
//  UIViewController+Extension.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import UIKit
import Foundation

extension UIViewController {
    func showNoInternetConnectionAlert() {
        let alert = UIAlertController(title: StringResources.noInternetTitle, message: StringResources.noInternetMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.backText, style: .default, handler: nil))
        present(alert, animated: true)
    }
}
