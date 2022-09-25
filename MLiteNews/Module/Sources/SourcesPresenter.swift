//
//  SourcesPresenter.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

class SourcesPresenter: SourcesPresenterProtocol {

    // MARK: Properties
    weak var view: SourcesViewProtocol?
    let interactor: SourcesInteractorProtocol
    let wireframe: SourcesWireframeProtocol
    
    var sourcesList: [SourceModel]?
    var category: String
    
    init(interactor: SourcesInteractorProtocol, wireframe: SourcesWireframeProtocol, category: String) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.sourcesList = []
        self.category = category
    }
    
    func fetchSources() {
        interactor.getSources(category: category)
    }
    
    func moveToNewsBySource(with source: SourceModel) {
        wireframe.pushToNewsBySource(with: source)
    }
}

extension SourcesPresenter: SourcesInteractorDelegate {
    
    func getSourcesDidSuccess(result: SourceListModel) {
        self.sourcesList = result.sources
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        
    }
    
    func userUnAuthorized() {
        
    }
    
}
