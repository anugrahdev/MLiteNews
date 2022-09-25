//
//  NewsRequest.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import Foundation

struct NewsRequest: Codable {
    var pageSize: Int
    var page: Int
    var q: String
    var language: String
    var sources: String?
}
