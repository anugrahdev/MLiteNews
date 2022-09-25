//
//  DetailPresenter.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 24/09/22.
//  
//

import Foundation

class DetailPresenter: DetailPresenterProtocol {

    // MARK: Properties
    weak var view: DetailViewProtocol?
    let interactor: DetailInteractorProtocol
    let wireframe: DetailWireframeProtocol
    
    var url: URL?
    var title: String?
    
    init(interactor: DetailInteractorProtocol, wireframe: DetailWireframeProtocol, url: URL, title: String) {
        self.interactor = interactor
        self.wireframe = wireframe
        self.url = url
        self.title = title
    }
}

extension DetailPresenter: DetailInteractorDelegate {
    
    func serviceRequestDidFail(_ error: NSError) {
        
    }
    
    func userUnAuthorized() {
        
    }
    
}
