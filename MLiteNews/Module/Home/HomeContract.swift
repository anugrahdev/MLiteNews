//
//  HomeContract.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

protocol HomeViewProtocol: BaseViewProtocol {
    func reloadData()
}

protocol HomePresenterProtocol: BasePresenterProtocol {
    var newsArticleList: [ArticleModel]? { set get }
    var categoryList: [CategoryModel] { get set }
    var totalPage: Int { get }
    var currentPage: Int { get set }
    var isLoadData: Bool { get set }
    var searchQuery: String { get set }
    
    func resetData()
    func fetchHomeNews()
    func moveToSourcesView(category: String)
    func moveToDetail(url: URL, title: String)
}

protocol HomeWireframeProtocol: BaseWireframeProtocol {
    func pushToSourcesView(category: String)
    func pushToDetail(url: URL, title: String)
}

protocol HomeInteractorProtocol: BaseInteractorProtocol {
    func getHomeNews(request: NewsRequest)
}

protocol HomeInteractorDelegate: BaseInteractorDelegate {
    func getHomeNewsDidSuccess(result: NewsModel?)
}
