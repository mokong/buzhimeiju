//
//  MeiJuHomeResItem.swift
//  meijuplay
//
//  Created by Horizon on 7/12/2021.
//

import Foundation
import UIKit

enum EpisodeType: String {
    case MeiJu = "1"
    case HanJu = "2"
    case RiJu = "3"
    case TaiJu = "4"
    case RecentVisited = "98"
    case UserCollect = "99"
    case Recommend = "100"
}

struct MeiJuItem: Decodable {
    
    var itemId: String?
    var title: String?
    var otitle: String?
    var zhuyan: String?
    var daoyan: String?
    var jianjie: String?
    var zhuti: String?
    var img: String?
  
  enum CodingKeys: String, CodingKey {
    case itemId = "id"
    case title
    case otitle
    case zhuyan
    case daoyan
    case jianjie
    case zhuti
    case img
  }
}

struct MeiJuListResItem: Decodable {
    var list: [MeiJuItem]?
    
    enum CodingKeys: String, CodingKey {
        case list
    }
}

struct MeiJuHomeResItem: Decodable {
    var lunbo: [MeiJuItem]?
    var meiju: [MeiJuItem]?
    var hanju: [MeiJuItem]?
    var riju: [MeiJuItem]?
    var taiju: [MeiJuItem]?
    
    enum CodingKeys: String, CodingKey {
        case lunbo
        case meiju
        case hanju
        case riju
        case taiju
    }
    
    func formatToDisplayDataList() -> [MeiJuHomeDataItem] {
        var resultList: [MeiJuHomeDataItem] = []
        
        var isSupportMeiJu = true
        var isSupportTaiJu = true
        var isSupportHanJu = true
        var isSupportRiJu = true
        
        let meijuItem = getHomeDataItem(with: 1)
        let hanjuItem = getHomeDataItem(with: 2)
        let rijuItem = getHomeDataItem(with: 3)
        let taijuItem = getHomeDataItem(with: 4)
        
        if isSupportMeiJu {
            resultList.append(meijuItem)
        }
        
        if isSupportHanJu {
            resultList.append(hanjuItem)
        }
        
        if isSupportRiJu {
            resultList.append(rijuItem)
        }
        
        if isSupportTaiJu {
            resultList.append(taijuItem)
        }
        return resultList
    }
    
    fileprivate func getHomeDataItem(with type: Int) -> MeiJuHomeDataItem {
        var title: String = ""
        var list: [MeiJuItem]?
        switch type {
            case 1:
                title = "人气美剧"
                list = meiju
            case 2:
                title = "人气韩剧"
                list = hanju
            case 3:
                title = "人气日剧"
                list = riju
            case 4:
                title = "人气泰剧"
                list = taiju
            default:
                title = ""
                list = []
        }
        
        var item = MeiJuHomeDataItem()
        item.typeTitle = title
        item.type = type
        if let tempList = list {
            item.list = tempList
        }
        return item
    }
    
}

struct MeiJuHomeDataItem {
    var type: Int = 0 // 1-美剧；2-韩剧；3-日剧；4-泰剧
    var typeTitle: String = ""
    var list: [MeiJuItem] = []
}
