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
    let searchController = UISearchController()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.fetchHomeNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Home"
        setupSearchController()
    }
    
    // MARK: - Setup
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        homeTableView.separatorStyle = .none
        homeTableView.register(ArticleTableViewCell.nib(), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        homeTableView.register(CategoryTableViewCell.nib(), forHeaderFooterViewReuseIdentifier: CategoryTableViewCell.identifier)
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.doingSearch(_:)), object: nil)
        self.perform(#selector(self.doingSearch), with: nil, afterDelay: 1)
    }
    
    @objc func doingSearch(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            presenter?.resetData()
            presenter?.searchQuery = text
            presenter?.fetchHomeNews()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchQuery = ""
        presenter?.resetData()
        presenter?.fetchHomeNews()
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
        presenter?.newsArticleList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        if let data = presenter?.newsArticleList?[indexPath.row] {
            cell.configure(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: CategoryTableViewCell.identifier)
                as? CategoryTableViewCell
        else {
            return nil
        }
        headerView.delegate = self
        headerView.categories = presenter?.categoryList
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y + scrollView.frame.size.height
        let scrollView = scrollView.contentSize.height
        let totalPage = presenter?.totalPage ?? 1
        let currentPage = presenter?.currentPage ?? 1
        let isLoadData = presenter?.isLoadData
        if scrollOffset > scrollView, isLoadData == false, totalPage != 1 {
            let nextPage = currentPage + 1
            if nextPage <= totalPage {
                presenter?.isLoadData = true
                presenter?.currentPage = nextPage
                presenter?.fetchHomeNews()
            }
        }
    }
    
}

extension HomeViewController: CategoryTableViewCellDelegate {
    func categoryDidTapped(category: String) {
        presenter?.moveToSourcesView(category: category)
    }
}
