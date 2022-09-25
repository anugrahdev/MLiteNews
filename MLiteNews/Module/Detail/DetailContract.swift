//
//  DetailContract.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 24/09/22.
//  
//

import Foundation

protocol DetailViewProtocol: BaseViewProtocol {}

protocol DetailPresenterProtocol: BasePresenterProtocol {
    var url: URL? { set get }
    var title: String? { set get }
}

protocol DetailWireframeProtocol: BaseWireframeProtocol {}

protocol DetailInteractorProtocol: BaseInteractorProtocol {}

protocol DetailInteractorDelegate: BaseInteractorDelegate {}
