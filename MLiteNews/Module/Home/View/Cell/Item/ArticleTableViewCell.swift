//
//  ArticleTableViewCell.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    static var identifier: String = "ArticleTableViewCell"

    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescLabel: UILabel!
    @IBOutlet weak var articlePublisherTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        containerView.makeCardShadow(opacity: 0.5)
        containerView.makeCardCorner()
        containerView.clipsToBounds = true
    }
    
    func configure(with data: ArticleModel) {
        articleImage.kf.setImage(with: URL(string: data.urlToImage ?? ""), placeholder: UIImage(named: "placeholder"))
        articleTitleLabel.text = data.title
        articleDescLabel.text = data.articleDescription
        if let source = data.source?.name, let publishedAt = data.publishedAt, let formattedDate = publishedAt.toDate()?.toFormattedDate() {
            articlePublisherTimeLabel.text = "\(source) - \(formattedDate)"
        }
    }
    
}
