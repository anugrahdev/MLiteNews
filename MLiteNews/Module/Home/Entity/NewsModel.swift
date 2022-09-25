//
//  NewsModel.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import Foundation
import UIKit

// MARK: - NewsModel
struct NewsModel: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleModel]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

// MARK: - Article
struct ArticleModel: Codable {
    var source: SourceModel?
    var author: String?
    var title: String?
    var articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

// MARK: - SourceModel
struct SourceModel: Codable {
    var id: String?
    var name: String?
    var sourceModelDescription: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    var bgColor: UIColor = .random()

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sourceModelDescription = "description"
        case url = "url"
        case category = "category"
        case language = "language"
        case country = "country"
    }
}
