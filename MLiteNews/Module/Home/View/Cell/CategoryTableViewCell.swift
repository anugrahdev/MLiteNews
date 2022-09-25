//
//  CategoryTableViewCell.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

protocol CategoryTableViewCellDelegate: AnyObject {
    func categoryDidTapped(category: String)
}


class CategoryTableViewCell: UITableViewCell {

    static var identifier: String = "CategoryTableViewCell"

    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    weak var delegate: CategoryTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }
    
    var categories: [Category]? {
        didSet {
            categoriesCollectionView.reloadData()
        }
    }

    private func setupCollection() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.register(CategoryItemCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoryItemCollectionViewCell.identifier)
        categoriesCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCollectionViewCell.identifier, for: indexPath) as? CategoryItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.makeCircleCorner()
        if let data = categories?[indexPath.row] {
            cell.configure(with: data)
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var offset = targetContentOffset.pointee
        let width = (SizeUtils.shared.screenWidth/2) - 6

        let index = offset.x / (width)
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * (width), y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let category = categories?[indexPath.row] {
            delegate?.categoryDidTapped(category: category.rawValue)
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (SizeUtils.shared.screenWidth/3)
        let height = CGFloat(250)
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .init(5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
}
