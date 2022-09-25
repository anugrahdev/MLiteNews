//
//  SourceTableViewCell.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

class SourceTableViewCell: UITableViewCell, TableViewCellProtocol {
    static var identifier: String = "SourceTableViewCell"
    
    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var sourceDescName: UILabel!
    @IBOutlet weak var sourceCategoryLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var sourceNameVIew: UIView!
    @IBOutlet weak var sourceInitialLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with data: SourceModel) {
        sourceDescName.text = data.sourceModelDescription
        sourceCategoryLabel.text = data.category
        sourceNameLabel.text = data.name
        sourceInitialLabel.text = data.name?.initials
        sourceNameVIew.backgroundColor = data.bgColor
    }
    
}
