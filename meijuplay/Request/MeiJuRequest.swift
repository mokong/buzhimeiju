//
//  MeiJuAPIManager.shared.swift
//  meijuplay
//
//  Created by Horizon on 7/12/2021.
//

import UIKit
import Alamofire

let kHTTPRequestPrefix = "http://ios.luomeidi.com/"

class MeiJuRequest: NSObject {
    
    /// homepage request
    class func homepageRequest(_ completion: ((MeiJuHomeResItem?) -> ())?) {
        let requestUrl = kHTTPRequestPrefix + "Meiju/newmeiju/"
        AF.request(requestUrl).responseDecodable(of: MeiJuHomeResItem.self) { response in
            guard let resItem = response.value else {
                completion?(nil)
                return
            }
            
            completion?(resItem)
        }
    }
    
    /// episode list request
    /// meiju1: http://ios.luomeidi.com/Meiju/newmeijulist/p/1/type/1
    /// meiju2: http://ios.luomeidi.com/Meiju/newmeijulist/p/2/type/1
    /// hanju :  http://ios.luomeidi.com/Meiju/newmeijulist/p/1/type/2
    /// riju  :
    class func episodeListReques(pageNum: Int, typeStr: String, completion: ((MeiJuListResItem?) -> (Void))?) {
        let requestUrl = kHTTPRequestPrefix + "Meiju/newmeijulist/p/" + String(format: "%ld", pageNum) + "/type/" + typeStr
        AF.request(requestUrl).responseDecodable(of: MeiJuListResItem.self) { response in
            guard let resItem = response.value else {
                completion?(nil)
                return
            }
            
            completion?(resItem)
        }
    }
    
    /// episode detail
    /// http://ios.luomeidi.com/Meiju/newxiangxi/iid/8666
    class func episodeDetailRequest(with iid: String, completion: ((MeiJuEpisodeSeasonItem?) -> (Void))?) {
        let requestUrl = kHTTPRequestPrefix + "Meiju/newxiangxi/iid/" + iid
        
        AF.request(requestUrl).responseDecodable(of: MeiJuEpisodeSeasonItem.self) { response in
            guard let resItem = response.value else {
                completion?(nil)
                return
            }
            
            completion?(resItem)
        }
    }
    
    /// episode search
    /// http://ios.luomeidi.com/Meiju/newappsou/name/犯罪心理
    class func searchEpisodeRequest(with title: String, completion: ((MeiJuSearchResItem?) -> (Void))?) {
        let escapedString = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let requestUrl = kHTTPRequestPrefix + "Meiju/newappsou/name/" + escapedString!
        AF.request(requestUrl).responseDecodable(of: MeiJuSearchResItem.self) { response in
            guard let resItem = response.value else {
                completion?(nil)
                return
            }
            
            completion?(resItem)
        }
    }
    
}
