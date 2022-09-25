//
//  NewsInteractor.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

class NewsInteractor: NewsInteractorProtocol {

    // MARK: Properties
    weak var delegate: NewsInteractorDelegate?
    
    func getNews(request: NewsRequest) {
        let url = "\(Constants.baseURL)top-headlines"
        let params: [String: Any] = ["sources": request.sources, "pageSize": request.pageSize, "page": request.page, "q": request.q]
        
        RestApiServices.shared.request(url: url, params: params) { [weak self] (newsResult: NewsModel) in
            self?.delegate?.getNewsDidSuccess(result: newsResult)
        } failure: { [weak self] error in
            self?.delegate?.serviceRequestDidFail(error)
        }
    }
    
}
