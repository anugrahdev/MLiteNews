//
//  DetailViewController.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 24/09/22.
//  
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var detailWebView: WKWebView!
    var presenter: DetailPresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = presenter?.title ?? ""
    }
    
    // MARK: - Setup
    private func setupView() {
        if let loadUrl = presenter?.url {
            detailWebView.load(URLRequest(url: loadUrl))
            detailWebView.allowsBackForwardNavigationGestures = true
        }
    }

}

// MARK: - View Protocol
extension DetailViewController: DetailViewProtocol {}
