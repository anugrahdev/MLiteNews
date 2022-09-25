//
//  HomeViewController.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var homeTableView: UITableView!
    var presenter: HomePresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.fetchHomeNews()
        title = "Home"
    }
    
    // MARK: - Setup
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        homeTableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        homeTableView.register(LatestNewsTableViewCell.nib(), forCellReuseIdentifier: LatestNewsTableViewCell.identifier)
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }

}

// MARK: - View Protocol
extension HomeViewController: HomeViewProtocol {
    func reloadData() {
        homeTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.homeComponent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter?.homeComponent[indexPath.row] {
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            cell.delegate = self
            cell.categories = Category.allCases
            return cell
        case .news:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LatestNewsTableViewCell.identifier, for: indexPath) as? LatestNewsTableViewCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            cell.news = presenter?.newsList
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}

extension HomeViewController: CategoryTableViewCellDelegate {
    func categoryDidTapped(category: String) {
        presenter?.moveToSourcesView(category: category)
    }
}
