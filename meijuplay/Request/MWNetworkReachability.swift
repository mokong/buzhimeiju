//
//  MWNetworkReachability.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation
import Alamofire
import Toast_Swift

class MWNetworkReachability {
    
    static let shared = MWNetworkReachability()
    let reachabilityManager = NetworkReachabilityManager(host: "www.baidu.com")
    
    func startNetworkMonitoring() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                self.showOfflineAlert()
            case .reachable(.cellular):
                self.dismissOfflineAlert()
            case .reachable(.ethernetOrWiFi):
                self.dismissOfflineAlert()
            case .unknown:
                print("Unknown network state")
            }
        })
    }
    
    func showOfflineAlert() {
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        rootVC?.view.makeToast("Please connect to network and try again")
    }
    
    func dismissOfflineAlert() {
        let rootVC = UIApplication.shared.windows.first?.rootViewController
        rootVC?.view.hideToast()
    }
}
