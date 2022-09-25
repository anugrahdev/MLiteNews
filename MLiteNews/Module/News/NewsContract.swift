//
//  NewsContract.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

protocol NewsViewProtocol: BaseViewProtocol {
    func reloadData()
}

protocol NewsPresenterProtocol: BasePresenterProtocol {
    var source: SourceModel { get set }
    var newsArticleList: [ArticleModel]? { get set }
    var totalPage: Int { get }
    var currentPage: Int { get set }
    var isLoadData: Bool { get set }
    var searchQuery: String { get set }

    func fetchNews()
    func resetData()
    func moveToDetail(url: URL, title: String)
}

protocol NewsWireframeProtocol: BaseWireframeProtocol {
    func pushToDetail(url: URL, title: String)
}

protocol NewsInteractorProtocol: BaseInteractorProtocol {
    func getNews(request: NewsRequest)
}

protocol NewsInteractorDelegate: BaseInteractorDelegate {
    func getNewsDidSuccess(result: NewsModel)
}
