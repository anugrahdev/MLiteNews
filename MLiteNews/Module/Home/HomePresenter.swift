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
    
    var newsList: [ArticleModel]?
    var homeComponent: [HomeComponent]

    init(interactor: HomeInteractorProtocol, wireframe: HomeWireframeProtocol) {
        self.interactor = interactor
        self.wireframe = wireframe
        homeComponent = [.category, .news]
    }
    
    func fetchHomeNews() {
        interactor.getHomeNews()
    }
    
    func moveToSourcesView(category: String) {
        wireframe.pushToSourcesView(category: category)
    }
}

extension HomePresenter: HomeInteractorDelegate {
    
    func getHomeNewsDidSuccess(result: NewsModel?) {
        newsList = result?.articles
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        
    }
    
    func userUnAuthorized() {
        
    }
    
}
