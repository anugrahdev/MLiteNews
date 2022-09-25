//
//  HomeInteractor.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation

class HomeInteractor: HomeInteractorProtocol {

    // MARK: Properties
    weak var delegate: HomeInteractorDelegate?
    
    func getHomeNews() {
        let getHomeNewsUrl = "\(Constants.baseURL)top-headlines"
        let params: [String: Any] = ["country": "id"]
        
        RestApiServices.shared.request(url: getHomeNewsUrl, params: params) { [weak self] (newsResult: NewsModel) in
            self?.delegate?.getHomeNewsDidSuccess(result: newsResult)
        } failure: { [weak self] error in
            self?.delegate?.serviceRequestDidFail(error)
        }

    }
    
}
