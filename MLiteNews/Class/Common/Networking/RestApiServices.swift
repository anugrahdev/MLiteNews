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
            "x-api-key": "11dc6c0b1fc14ae5969b10875ddacb22"
        ]
        
        AF.request(url, method: .get, parameters: params, headers: headers)
            .validate(statusCode: 200..<400)
            .responseDecodable(of: T.self){ response in
                debugPrint(response)
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                do {
                    let decoder = JSONDecoder()
                    let errorData = try decoder.decode(NewsErrorModel.self, from: response.data ?? Data())
                    let customError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: errorData.message ?? error.localizedDescription])
                    failure(customError)
                } catch {
                    failure(error as NSError)
                }
            }
        }
        
    }
    
}
