//
//  MeiJuSetModule.swift
//  meijuplay
//
//  Created by Horizon on 16/12/2021.
//

import Foundation
import SnapKit
import Toast_Swift

class MeiJuSetModule {
    // MARK: - properties
    private(set) lazy var view = MeiJuSetView()
    fileprivate weak var vc: MeiJuSetController?
    fileprivate var dataList: [[MeiJuSetItem]] = [[]]
    
    // MARK: - init
    init(_ vc: MeiJuSetController) {
        self.vc = vc
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        weak var weakSelf = self
        view.switchChangedCallback = { item in
            weakSelf?.handleSwitchChanged(item)
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - utils
    func initData() {
        var episodeList: [MeiJuSetItem] = []
        var searchList: [MeiJuSetItem] = []
        
        let typeEpisodeList: [EpisodeType] = [.MeiJu, .HanJu, .RiJu, .TaiJu]
        let typeSearchList: [EpisodeType] = [.Recommend, .UserCollect, .RecentVisited]
        for type in typeEpisodeList {
            let keyStr = MeiJuSetItem.savedKeyStr(type)
            let meijuItem = MeiJuSetItem.customItem(type, saveKeyStr: keyStr)
            episodeList.append(meijuItem)
        }
        
        for type in typeSearchList {
            let keyStr = MeiJuSetItem.savedKeyStr(type)
            let meijuItem = MeiJuSetItem.customItem(type, saveKeyStr: keyStr)
            searchList.append(meijuItem)
        }
        
        self.dataList = [episodeList, searchList]
        view.update(dataList)
    }
    
    fileprivate func getEnabledCount() -> Int {
        var count = 0
        let typeList: [EpisodeType] = [.MeiJu, .HanJu, .RiJu, .TaiJu]
        for type in typeList {
            let isEnable = MeiJuSetItem.savedEnableValue(type)
            if isEnable == "1" {
                count += 1
            }
        }
        return count
    }
        
    func handleNeedUpdateListView() {
        let count = getEnabledCount()
        if count <= 1 {
            let type = MeiJuSetItem.getEpisodeEnabledType()
            ProjectConsts.shared.update(type: type)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: KTypeChangedNote), object: nil)
        }
    }
    
    // MARK: - action
    fileprivate func handleSwitchChanged(_ item: MeiJuSetItem) {
        
        if item.type == .RiJu ||
            item.type == .MeiJu ||
            item.type == .HanJu ||
            item.type == .TaiJu {
            let count = getEnabledCount()
            if count <= 1, item.isEnable != true {
                self.view.makeToast("最少需要打开一个呢")
                ProjectConsts.shared.update(type: item.type)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: KTypeChangedNote), object: nil)
                
                initData()
                return
            }
        }
        
        MeiJuSetItem.save(item.type, isEnable: item.isEnable)
        NotificationCenter.default.post(name: Notification.Name(rawValue: KSwitchChangedNote), object: nil)
    }
    
    // MARK: - other
    

}
