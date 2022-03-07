//
//  MeiJuAPIManager.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import UIKit

class MeiJuAPIManager: MWAPIManager {
    static let shared = MeiJuAPIManager()

    /// homepage request
    func homepageRequest(_ completion: ((MeiJuHomeResItem?) -> ())?) {
        sessionManager.request(MeiJuRouter.homepageRequest).responseDecodable(of: MeiJuHomeResItem.self) { response in
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
    func episodeListRequest(pageNum: Int, typeStr: String, completion: ((MeiJuListResItem?) -> (Void))?) {
        sessionManager.request(MeiJuRouter.eposideListRequest(pageNum, typeStr)).responseDecodable(of: MeiJuListResItem.self) { response in
            guard let resItem = response.value else {
                if pageNum == 1 {
                    let item = MeiJuDB.getSavedListData(from: typeStr)
                    completion?(item)
                }
                else {
                    completion?(nil)
                }
                return
            }
            
            if pageNum == 1 && resItem.list != nil { // 请求成功了才存储
                let dbItem = MeiJuListDBItem()
                dbItem.typeStr = typeStr
                if let data = response.data {
                    let string = String(data: data, encoding: .utf8)
                    dbItem.jsonDataStr = string
                }
                MeiJuDB.saveListItemData(dbItem)
            }
            
            completion?(resItem)
        }
    }
    
    /// episode detail
    /// http://ios.luomeidi.com/Meiju/newxiangxi/iid/8666
    func episodeDetailRequest(with iid: String, completion: ((MeiJuEpisodeSeasonItem?) -> (Void))?) {
        sessionManager.request(MeiJuRouter.eposideDetailRequest(iid)).responseDecodable(of: MeiJuEpisodeSeasonItem.self) { response in
            guard let resItem = response.value else {
                completion?(nil)
                return
            }
            
            completion?(resItem)
        }
    }
    
    /// episode search
    /// http://ios.luomeidi.com/Meiju/newappsou/name/犯罪心理
    func searchEpisodeRequest(with title: String, completion: ((MeiJuSearchResItem?) -> (Void))?) {
        let escapedString = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        sessionManager.request(MeiJuRouter.searchRequest(escapedString!)).responseDecodable(of: MeiJuSearchResItem.self) { response in
            guard let resItem = response.value else {
                completion?(nil)
                return
            }
            
            completion?(resItem)
        }
    }
    
}
