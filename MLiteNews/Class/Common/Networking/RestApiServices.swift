//
//  RestApiService.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 23/09/22.
//

import Foundation
import Alamofire

class RestApiServices {
    
    static let shared = {
        RestApiServices()
    }()
    
    func request<T: Codable>(url: String, params: [String: Any], success: @escaping (T) -> Void, failure: @escaping (NSError) -> Void) {
        let headers: HTTPHeaders = [
            "x-api-key": "f94284f2e06e421baa4ca1e4cc9ab283"
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: T.self){ response in
                debugPrint(response)
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error as NSError)
            }
        }
        
    }
    
}
