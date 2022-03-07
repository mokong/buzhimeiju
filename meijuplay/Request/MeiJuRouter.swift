//
//  MeiJuRouter.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation
import Alamofire

enum MeiJuRouter {
    case homepageRequest
    case eposideListRequest(Int, String)
    case eposideDetailRequest(String)
    case searchRequest(String)
    
    var baseURL: String {
        return "http://ios.luomeidi.com/Meiju"
    }
    
    var path: String {
        switch self {
        case .homepageRequest:
            return "/newmeiju/"
        case .eposideListRequest(let page, let type):
            let pageStr = String(format: "%ld", page)
            return "/newmeijulist/p/\(pageStr)/type/\(type)"
        case .eposideDetailRequest(let iid):
            return "/newxiangxi/iid/\(iid)"
        case .searchRequest(let name):
            return "/newappsou/name/\(name)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String: String]? {
        return nil
    }
}

// MARK: - URLRequestConvertible
extension MeiJuRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL().appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        if method == .get {
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        } else if method == .post {
            request = try JSONParameterEncoder().encode(parameters, into: request)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        return request
    }
}
