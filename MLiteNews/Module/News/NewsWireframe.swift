//
//  NewsWireframe.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation
import UIKit
import AVFAudio

class NewsWireframe: NewsWireframeProtocol {
    
    weak var controller: NewsViewController?
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setupNewsViewController(source: SourceModel) -> NewsViewController {
        let interactor = NewsInteractor()
        let presenter = NewsPresenter(interactor: interactor, wireframe: self, source: source)
        let view = NewsViewController()
        interactor.delegate = presenter
        controller = view
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
    func setLoadingIndicator(isHidden: Bool) {
        
    }
    
    func showNoInternetAlert() {
        
    }
    
    func showErrorAlert(_ message: String) {
        
    }
    
    func pushToDetail(url: URL, title: String) {
        let router = resolver.resolve(Router.self)
        let viewController = router.setupDetailViewController(url: url, title: title)
        controller?.navigationController?.pushViewController(viewController, animated: true)
    }


}

extension Router {
    
    func setupNewsViewController(source: SourceModel) -> NewsViewController {
        let wireframe = NewsWireframe(resolver: resolver)
        return wireframe.setupNewsViewController(source: source)
    }
    
}
