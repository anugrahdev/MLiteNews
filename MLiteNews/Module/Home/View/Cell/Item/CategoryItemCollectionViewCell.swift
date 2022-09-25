//
//  CategoryItemCollectionViewCell.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

class CategoryItemCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {
    
    static var identifier: String = "CategoryItemCollectionViewCell"

    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with data: Category) {
        categoryLabel.text = data.rawValue
    }

}
