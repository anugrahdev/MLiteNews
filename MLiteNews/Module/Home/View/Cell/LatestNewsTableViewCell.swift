//
//  LatestNewsTableViewCell.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import UIKit

class LatestNewsTableViewCell: UITableViewCell {
    
    static var identifier: String = "LatestNewsTableViewCell"
    
    static func nib() -> UINib {
        return .init(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var latestNewsTableView: UITableView!
    
    var news: [ArticleModel]? {
        didSet {
            latestNewsTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }

    private func setupTableView() {
        latestNewsTableView.register(ArticleTableViewCell.nib(), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        latestNewsTableView.delegate = self
        latestNewsTableView.dataSource = self
    }
    
}

extension LatestNewsTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        if let data = news?[indexPath.row] {
            cell.configure(with: data)
        }
        return cell
    }
}
