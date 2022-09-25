//
//  SourcesInteractor.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

class SourcesInteractor: SourcesInteractorProtocol {

    // MARK: Properties
    weak var delegate: SourcesInteractorDelegate?
    
    func getSources(category: String) {
        let url = "\(Constants.baseURL)top-headlines/sources"
        let params: [String: Any] = ["category": category]
        
        RestApiServices.shared.request(url: url, params: params) { [weak self] (result: SourceListModel) in
            self?.delegate?.getSourcesDidSuccess(result: result)
        } failure: { [weak self] error in
            self?.delegate?.serviceRequestDidFail(error)
        }
    }
    
}
