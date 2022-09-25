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
        if isHidden {
            controller?.sourcesTableView.hideLoading()
        } else {
            controller?.sourcesTableView.showLoading()
        }
    }
    
    func showNoInternetAlert() {
        let alert = UIAlertController(title: StringResources.noInternetTitle, message: StringResources.noInternetMsg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.backText, style: .default, handler: nil))
        self.controller?.present(alert, animated: true)
    }
    
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: StringResources.errorLoadData, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringResources.backText, style: .default, handler: nil))
        self.controller?.present(alert, animated: true)
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
