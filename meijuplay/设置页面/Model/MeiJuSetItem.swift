//
//  MeiJuSetItem.swift
//  meijuplay
//
//  Created by Horizon on 16/12/2021.
//

import Foundation

struct MeiJuSetItem {
    var title: String?
    var type: EpisodeType = EpisodeType.MeiJu
    var isEnable: Bool = false // 是否打开
    
    
    static func customItem(_ type: EpisodeType, saveKeyStr: String) -> MeiJuSetItem {
        var item = MeiJuSetItem()
        item.type = type
        item.title = MeiJuSetItem.titleFromType(type)
        
        let value = MeiJuSetItem.savedEnableValue(type)
        item.isEnable = value.boolValue
        
        return item
    }
    
    // 按顺序获取当前剧集打开的类型
     static func getEpisodeEnabledType() -> EpisodeType {
        var targetType = EpisodeType.MeiJu
        let typeList: [EpisodeType] = [.MeiJu, .HanJu, .RiJu, .TaiJu]
        for type in typeList {
            let isEnable = MeiJuSetItem.savedEnableValue(type)
            if isEnable == "1" {
                targetType = type
                break
            }
        }
        return targetType
    }
    
    /// 保存开关状态
    static func save(_ type: EpisodeType, isEnable: Bool) {
        let keyStr = MeiJuSetItem.savedKeyStr(type)
        let str = String(format: "%ld", isEnable)
        UserDefaults.standard.setValue(str, forKey: keyStr)
    }
    
    ///  根据 Type 获取 value
    /// - Parameter type: type
    /// - Returns: value
    static func savedEnableValue(_ type: EpisodeType) -> NSString {
        var resultStr: NSString = "1"
        let keyStr = MeiJuSetItem.savedKeyStr(type)
        if let str = UserDefaults.standard.value(forKey: keyStr) as? NSString {
            resultStr = str
        }
        return resultStr
    }
    
    /// 根据 type 获取 Key
    /// - Parameter type: type
    /// - Returns: key
    static func savedKeyStr(_ type: EpisodeType) -> String {
        var resultKeyStr = ""
        switch type {
        case .MeiJu:
            resultKeyStr = "kIsEnableMeiJu"
        case .HanJu:
            resultKeyStr = "kIsEnableHanJu"
        case .RiJu:
            resultKeyStr = "kIsEnableRiJu"
        case .TaiJu:
            resultKeyStr = "kIsEnableTaiJu"
        case .RecentVisited:
            resultKeyStr = "kIsEnableVisited"
        case .UserCollect:
            resultKeyStr = "kIsEnableCollected"
        case .Recommend:
            resultKeyStr = "kIsEnableRecommend"
        default:
            resultKeyStr = ""
        }
        return resultKeyStr
    }
        
    static func titleFromType(_ type: EpisodeType) -> String {
        var resultStr = ""
        switch type {
        case .MeiJu:
            resultStr = "美剧"
        case .HanJu:
            resultStr = "韩剧"
        case .RiJu:
            resultStr = "日剧"
        case .TaiJu:
            resultStr = "泰剧"
        case .RecentVisited:
            resultStr = "最近观看"
        case .UserCollect:
            resultStr = "收藏"
        case .Recommend:
            resultStr = "推荐"
        default:
            resultStr = ""
        }
        return resultStr
    }
}
