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
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        bgView.makeCardShadow(opacity: 0.5)
        bgView.makeCardCorner()
        bgView.clipsToBounds = true
    }
    
    func configure(with data: CategoryModel) {
        categoryLabel.text = data.name
        bgView.backgroundColor = data.color
    }

}
