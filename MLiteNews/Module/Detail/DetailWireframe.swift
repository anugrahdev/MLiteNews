//
//  DetailWireframe.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 24/09/22.
//  
//

import Foundation
import UIKit

class DetailWireframe: DetailWireframeProtocol {
    
    weak var controller: DetailViewController?
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setupDetailViewController(url: URL, title: String) -> DetailViewController {
        let interactor = DetailInteractor()
        let presenter = DetailPresenter(interactor: interactor, wireframe: self, url: url, title: title)
        let view = DetailViewController()
        interactor.delegate = presenter
        controller = view
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func pushLogin() {
        
    }
    
    func setLoadingIndicator(isHidden: Bool) {
        
    }
    
    func showNoInternetAlert() {
        
    }
    
    func showErrorAlert(_ message: String) {
        
    }

}

extension Router {
    
    func setupDetailViewController(url: URL, title: String) -> DetailViewController {
        let wireframe = DetailWireframe(resolver: resolver)
        return wireframe.setupDetailViewController(url: url, title: title)
    }
    
}
