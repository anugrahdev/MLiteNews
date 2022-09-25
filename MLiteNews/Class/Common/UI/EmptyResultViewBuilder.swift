//
//  EmptyResultViewBuilder.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation
import UIKit

class EmptyResultViewBuilder {
    private var emptyView = EmptyView()
    
    @discardableResult
    func setEmpty(_ title: String?) -> EmptyResultViewBuilder {
        emptyView.titleLabel.text = title
        return self
    }

    func build() -> EmptyView {
        return emptyView
    }
    
}
