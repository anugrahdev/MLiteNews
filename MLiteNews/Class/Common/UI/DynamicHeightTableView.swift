//
//  DynamicHeightTableView.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import Foundation
import UIKit

class DynamicHeightTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
