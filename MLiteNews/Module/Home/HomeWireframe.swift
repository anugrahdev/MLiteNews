//
//  HomeWireframe.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//  
//

import Foundation
import UIKit

class HomeWireframe: HomeWireframeProtocol {
    
    weak var controller: HomeViewController?
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func setupHomeViewController() -> HomeViewController {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor, wireframe: self)
        let view = HomeViewController()
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
    
    func pushToSourcesView(category: String) {
        let router = resolver.resolve(Router.self)
        let viewController = router.setupSourcesViewController(category: category)
        controller?.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension Router {
    
    func setupHomeViewController() -> HomeViewController {
        let wireframe = HomeWireframe(resolver: resolver)
        return wireframe.setupHomeViewController()
    }
    
}
