//
//  NewsViewController.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: NewsPresenterProtocol?

    @IBOutlet weak var newsTableView: UITableView!
    
    let searchController = UISearchController()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.fetchNews()
        title = "News from \(presenter?.source.name ?? "")"
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Setup
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        newsTableView.register(ArticleTableViewCell.nib(), forCellReuseIdentifier: ArticleTableViewCell.identifier)
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

}

extension NewsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.doingSearch(_:)), object: nil)
        self.perform(#selector(self.doingSearch), with: nil, afterDelay: 1)
    }
    
    @objc func doingSearch(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.resetData()
        presenter?.searchQuery = text
        presenter?.fetchNews()
    }
}


// MARK: - View Protocol
extension NewsViewController: NewsViewProtocol {
    func reloadData() {
        self.newsTableView.reloadData()
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.newsArticleList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.identifier, for: indexPath) as? ArticleTableViewCell,
              let data = presenter?.newsArticleList?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        cell.configure(with: data)
        return cell
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
                presenter?.fetchNews()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let stringUrl = presenter?.newsArticleList?[indexPath.row].url, let url = URL(string: stringUrl), let title = presenter?.newsArticleList?[indexPath.row].title {
            presenter?.moveToDetail(url: url, title: title)
        }
    }
}



