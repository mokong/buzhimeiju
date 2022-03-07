//
//  MWNetworkLogger.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation
import Alamofire

class MWNetworkLogger: EventMonitor {
    let queue: DispatchQueue = DispatchQueue(label: "com.morganwang.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(_ request: DataRequest,
                        didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) {
            print(json)
        }
    }
}
