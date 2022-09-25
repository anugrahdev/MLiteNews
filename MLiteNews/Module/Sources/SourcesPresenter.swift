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
    var sourcesResult: [SourceModel]?
    var category: String
    
    init(interactor: SourcesInteractorProtocol, wireframe: SourcesWireframeProtocol, category: String) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.sourcesList = []
        self.category = category
    }
    
    func fetchSources() {
        wireframe.setLoadingIndicator(isHidden: false)
        interactor.getSources(category: category)
    }
    
    func moveToNewsBySource(with source: SourceModel) {
        wireframe.pushToNewsBySource(with: source)
    }
    
    func filterSource(query: String) {
        if query.isEmpty {
            resetResult()
        } else {
            let result = self.sourcesResult?.filter({ source in
                source.name?.lowercased().contains(query) ?? false
            })
            self.sourcesList = result
        }
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func resetResult() {
        self.sourcesList = sourcesResult
    }
    
}

extension SourcesPresenter: SourcesInteractorDelegate {
    
    func getSourcesDidSuccess(result: SourceListModel) {
        self.sourcesList = result.sources
        self.sourcesResult = result.sources
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.view?.reloadData()
        }
    }
    
    func serviceRequestDidFail(_ error: NSError) {
        DispatchQueue.main.async { [weak self] in
            self?.wireframe.setLoadingIndicator(isHidden: true)
            self?.wireframe.showErrorAlert(error.localizedDescription)
        }
    }
    
}
