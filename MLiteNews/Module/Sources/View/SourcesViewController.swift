//
//  SourcesViewController.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import UIKit

class SourcesViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var sourcesTableView: UITableView!
    var presenter: SourcesPresenterProtocol?
    let searchController = UISearchController()
    let refreshControl = UIRefreshControl()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.fetchSources()
        title = presenter?.category ?? ""
        setupSearchController()
    }
    
    // MARK: - Setup
    private func setupView() {
        setupTableView()
        setupRefreshView()
    }
    
    private func setupTableView() {
        sourcesTableView.register(SourceTableViewCell.nib(), forCellReuseIdentifier: SourceTableViewCell.identifier)
        sourcesTableView.delegate = self
        sourcesTableView.dataSource = self
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupRefreshView() {
        refreshControl.attributedTitle = NSAttributedString(string: "Tarik untuk memperbarui")
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        sourcesTableView.addSubview(refreshControl)
    }
    
    @objc func refreshData(_ sender: AnyObject) {
        presenter?.resetData()
        self.refreshControl.endRefreshing()
        self.sourcesTableView.reloadData()
        presenter?.fetchSources()
    }
    
}

extension SourcesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.doingSearch(_:)), object: nil)
        self.perform(#selector(self.doingSearch), with: nil, afterDelay: 1)
    }
    
    @objc func doingSearch(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.filterSource(query: text.lowercased())
    }
}


// MARK: - View Protocol
extension SourcesViewController: SourcesViewProtocol {
    func reloadData() {
        self.sourcesTableView.reloadData()
    }
}

extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = presenter?.sourcesList?.count, let isLoading = presenter?.isLoadData {
            if count == 0 && !isLoading {
                tableView.setEmptyView(title: StringResources.dataNotFound)
            } else {
                tableView.restore()
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SourceTableViewCell.identifier, for: indexPath) as? SourceTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        if let data = presenter?.sourcesList?[indexPath.row] {
            cell.configure(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = presenter?.sourcesList?[indexPath.row] {
            presenter?.moveToNewsBySource(with: data)
        }
    }
}
