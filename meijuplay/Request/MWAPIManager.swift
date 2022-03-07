//
//  MWAPIManager.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation
import Alamofire

class MWAPIManager {
    public let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
//        configuration.timeoutIntervalForRequest = 30
//        if #available(iOS 11.0, *) {
//            configuration.waitsForConnectivity = true
//        } else {
//            // Fallback on earlier versions
//        }
        
        let resposneCacher = ResponseCacher(behavior: .modify({ _, response in
            let userInfo = ["date": Date()]
            return CachedURLResponse(response: response.response,
                                     data: response.data,
                                     userInfo: userInfo,
                                     storagePolicy: .allowed)
        }))
        
        let networkLogger = MWNetworkLogger()
        let interceptor = MWRequestInterceptor()
        
        return Session(configuration: configuration,
                       interceptor: interceptor,
                       cachedResponseHandler: resposneCacher,
                       eventMonitors: [networkLogger])
    }()
    
}
