//
//  ProjectConsts.swift
//  meijuplay
//
//  Created by Horizon on 8/12/2021.
//

import Foundation
import UIKit
import Alamofire

/// 屏幕宽度
let MWScreenWidth = UIScreen.main.bounds.size.width

/// 屏幕高度
let MWScreenHeight = UIScreen.main.bounds.size.height

/// 用户界面类型
let MWInterfaceIdiom = UIDevice.current.userInterfaceIdiom

/// type切换通知
let KTypeChangedNote = "KTypeChangedNote"

/// 设置开关切换通知
let KSwitchChangedNote = "KSwitchChangedNote"

/// 左侧功能 view宽度
let kLeftFuncViewW = MWScreenWidth * 0.36

/// 存储是否同意隐私政策的 Key
let kIsAgreePrivacy = "kIsAgreePrivacy"

/// 存储的美剧进度
let EpisodeTableName: String = "PlayedEpisodeInfo"

/// 存储收藏的美剧
let kFavoriteTableName: String = "kFavoriteTableName"

/// 存储最近播放的美剧
let kRecentPlayTableName: String = "kRecentPlayTableName"

/// 存储列表页第一页的数据
let kListCacheTableName: String = "kListCacheTableName"

/// 播放器的高度
let kPlayerViewH: CGFloat = MWScreenHeight * 0.36

/// 商店ID
let kAppStoreID = "1611529480"
/// 商店链接
let kAppStoreUrl = "https://apps.apple.com/cn/app/qq/id1611529480"
/// 商店评价链接
let kAppStoreCommentUrl = "itms-apps://itunes.apple.com/cn/app/id1611529480?mt=8&action=write-review"

class ProjectConsts {
    // MARK: - properties
    static let shared = ProjectConsts()
    private(set) var selectType: EpisodeType = EpisodeType.MeiJu
    var isInReview: Bool = true
    
    // MARK: - init
    private init() {
        self.selectType = MeiJuSetItem.getEpisodeEnabledType()
    }
    
    // MARK: - utils
    func update(type: EpisodeType) {
        if self.selectType == type {
            return
        }
        self.selectType = type
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KTypeChangedNote), object: nil)
    }
    
    func navTitle() -> String {
        switch selectType {
        case .MeiJu:
            return "热播美剧"
        case .HanJu:
            return "人气韩剧"
        case .RiJu:
            return "火热日剧"
        case .TaiJu:
            return "美丽泰剧"
        default:
            return ""
        }
    }
    
    // MARK: - action

    
    // MARK: - other
    

}
