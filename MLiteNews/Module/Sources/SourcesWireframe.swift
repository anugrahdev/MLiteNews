//
//  SourcesWireframe.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation
import UIKit

class SourcesWireframe: SourcesWireframeProtocol {
    
    weak var controller: SourcesViewController?
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setupSourcesViewController(category: String) -> SourcesViewController {
        let interactor = SourcesInteractor()
        let presenter = SourcesPresenter(interactor: interactor, wireframe: self, category: category)
        let view = SourcesViewController()
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
    
    func pushToNewsBySource(with source: SourceModel) {
        let router = resolver.resolve(Router.self)
        let viewController = router.setupNewsViewController(source: source)
        controller?.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension Router {
    
    func setupSourcesViewController(category: String) -> SourcesViewController {
        let wireframe = SourcesWireframe(resolver: resolver)
        return wireframe.setupSourcesViewController(category: category)
    }
    
}
