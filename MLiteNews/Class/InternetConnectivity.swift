//
//  InternetConnectivity.swift
//  MLiteNews
//
//  Created by Anang Nugraha on 25/09/22.
//

import Foundation
import Alamofire

struct InternetConnectivity {
    
    static let shared = InternetConnectivity()
    let manager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    static func isConnected() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func startObserver() {
        manager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .reachable(.cellular), .reachable(.ethernetOrWiFi): break
            case .notReachable, .unknown:
                NotificationCenter.default.post(name: .getNotification(with: .offline), object: nil)
            }
        })
    }
    
}
