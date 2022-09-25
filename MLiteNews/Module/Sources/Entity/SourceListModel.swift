//
//  SourceListModel.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import Foundation

// MARK: - SourceListModel
struct SourceListModel: Codable {
    var status: String?
    var sources: [SourceModel]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sources = "sources"
    }
}
