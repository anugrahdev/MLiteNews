//
//  SourcesContract.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

protocol SourcesViewProtocol: BaseViewProtocol {
    func reloadData()
}

protocol SourcesPresenterProtocol: BasePresenterProtocol {
    var sourcesResult: [SourceModel]? { get set }
    var sourcesList: [SourceModel]? { get set }
    var category: String { get set }
    func fetchSources()
    func moveToNewsBySource(with source: SourceModel)
    func filterSource(query: String)
    func resetResult()
}

protocol SourcesWireframeProtocol: BaseWireframeProtocol {
    func pushToNewsBySource(with source: SourceModel)
}

protocol SourcesInteractorProtocol: BaseInteractorProtocol {
    func getSources(category: String)
}

protocol SourcesInteractorDelegate: BaseInteractorDelegate {
    func getSourcesDidSuccess(result: SourceListModel)
}
