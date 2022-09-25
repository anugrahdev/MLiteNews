//
//  HomePresenter.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

class HomePresenter: HomePresenterProtocol {

    // MARK: Properties
    weak var view: HomeViewProtocol?
    let interactor: HomeInteractorProtocol
    let wireframe: HomeWireframeProtocol
    
    var newsArticleList: [ArticleModel]?
    var categoryList: [CategoryModel]
    var searchQuery: String
    var currentPage: Int
    let newsPerPage = 10
    var totalPage: Int
    var isLoadData: Bool

    init(interactor: HomeInteractorProtocol, wireframe: HomeWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.newsArticleList = []
        self.categoryList = Category.allCases.map { CategoryModel(name: $0.rawValue) }
        self.totalPage = 1
        self.currentPage = 1
        self.isLoadData = true
        self.searchQuery = ""
    }
    
    func fetchHomeNews() {
        wireframe.setLoadingIndicator(isHidden: false)
        let request = NewsRequest(pageSize: newsPerPage, page: currentPage, q: searchQuery, language: "en")
        interactor.getHomeNews(request: request)
    }
    
    func moveToSourcesView(category: String) {
        wireframe.pushToSourcesView(category: category)
    }
    
    func resetData() {
        newsArticleList = []
        totalPage = 1
        currentPage = 1
    }
    
    func moveToDetail(url: URL, title: String) {
        wireframe.pushToDetail(url: url, title: title)
    }

}

extension HomePresenter: HomeInteractorDelegate {
    
    func getHomeNewsDidSuccess(result: NewsModel?) {
        newsArticleList?.append(contentsOf: result?.articles ?? [])
        if let totalCount = result?.totalResults {
            var dataCurrentPage: Double = Double(totalCount / newsPerPage)
            dataCurrentPage.round(.up)
            totalPage = Int(dataCurrentPage)
        }
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.view?.reloadData()
        }
        isLoadData = false
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.wireframe.showErrorAlert(error.localizedDescription)
        }
    }
    
}
