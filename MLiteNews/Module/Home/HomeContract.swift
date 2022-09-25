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
    var newsList: [ArticleModel]? { set get }
    var homeComponent: [HomeComponent] { get set }

    func fetchHomeNews()
    func moveToSourcesView(category: String)
    
}

protocol HomeWireframeProtocol: BaseWireframeProtocol {
    func pushToSourcesView(category: String)
}

protocol HomeInteractorProtocol: BaseInteractorProtocol {
    func getHomeNews()
}

protocol HomeInteractorDelegate: BaseInteractorDelegate {
    func getHomeNewsDidSuccess(result: NewsModel?)
}
