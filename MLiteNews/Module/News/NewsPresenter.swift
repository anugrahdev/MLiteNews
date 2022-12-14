//
//  NewsPresenter.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation
import Alamofire

class NewsPresenter: NewsPresenterProtocol {
    
    
    // MARK: Properties
    weak var view: NewsViewProtocol?
    let interactor: NewsInteractorProtocol
    let wireframe: NewsWireframeProtocol
    let newsPerPage = 10
    
    var newsArticleList: [ArticleModel]?
    var source: SourceModel
    var isLoadData: Bool
    var totalPage: Int
    var currentPage: Int
    var searchQuery: String

    init(interactor: NewsInteractorProtocol, wireframe: NewsWireframeProtocol, source: SourceModel) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.source = source
        self.newsArticleList = []
        self.totalPage = 1
        self.currentPage = 1
        self.isLoadData = true
        self.searchQuery = ""
    }
    
    func fetchNews() {
        wireframe.setLoadingIndicator(isHidden: false)
        if let source = source.id {
            let request = NewsRequest(pageSize: newsPerPage, page: currentPage, q: searchQuery, language: "en", sources: source)
            interactor.getNews(request: request)
        }
    }
    
    func resetData() {
        newsArticleList = []
        totalPage = 1
        currentPage = 1
    }
    
    func moveToDetail(url: URL, title: String) {
        self.wireframe.pushToDetail(url: url, title: title)
    }
    
}

extension NewsPresenter: NewsInteractorDelegate {
    func getNewsDidSuccess(result: NewsModel) {
        newsArticleList?.append(contentsOf: result.articles ?? [])
        if let totalCount = result.totalResults {
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
