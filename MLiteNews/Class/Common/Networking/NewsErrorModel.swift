//
//  NewsErrorModel.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation

// MARK: - NewsErrorModel
struct NewsErrorModel: Codable {
    var status: String?
    var code: String?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case code = "code"
        case message = "message"
    }
}
