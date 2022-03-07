//
//  MeiJuSearchSuggestViewModule.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import Foundation
import SnapKit

class MeiJuSearchSuggestViewModule {
    // MARK: - properties
    fileprivate weak var vc: MeiJuSearchVC?
    fileprivate lazy var view = MeiJuSearchSuggestView(frame: .zero)
    fileprivate lazy var favoriteView = MeiJuSearchSuggestView(frame: .zero)
    fileprivate lazy var recentPlayView = MeiJuSearchSuggestView(frame: .zero)
    
    fileprivate var favoriteList: [MeiJuDBItem] = []
    fileprivate var recentPlayList: [MeiJuDBItem] = []
    
    // MARK: - init
    init(_ vc: MeiJuSearchVC) {
        self.vc = vc
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        self.vc?.view.addSubview(favoriteView)
        self.vc?.view.addSubview(recentPlayView)
        
        view.selectItemCallback = { [weak self] (item, index) in
            if let itemStr = item as? String {
                self?.handleSelectItem(itemStr)
            }
        }
        
        favoriteView.selectItemCallback = { [weak self] (item, index) in
            self?.handleFavorite(at: index)
        }
        
        recentPlayView.selectItemCallback = { [weak self] (item, index) in
            self?.handleRecentPlay(at: index)
        }
    }
    
    func install() {
        var viewTop = -28.0
        if view.isHidden {
            viewTop = 0.0
        }
        view.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(vc!.searchBarModule!.view.snp.bottom).inset(viewTop)
        }
        
        var favoriteViewTop = -28.0
        if favoriteView.isHidden {
            favoriteViewTop = 0.0
        }
        favoriteView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.bottom).inset(favoriteViewTop)
        }
        
        var recentPlayViewTop = -28.0
        if recentPlayView.isHidden {
            recentPlayViewTop = 0.0
        }
        recentPlayView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(favoriteView.snp.bottom).inset(recentPlayViewTop)
        }
    }
    
    func initData() {
        initRecommendData()
        
        initFavoriteData()
        
        initRecentPlayData()
    }
    
    fileprivate func initRecommendData() {
        let isEnable = MeiJuSetItem.savedEnableValue(EpisodeType.Recommend)
        if isEnable == "1" {
            let list = ["怀疑", "菜鸟老警", "侠探杰克", "指定幸存者", "海军罪案调查处：洛杉矶"]
            view.isHidden = false
            view.update(with: "推荐", descList: list as [AnyObject])
        }
        else {
            view.isHidden = true
        }
    }
    
    fileprivate func initFavoriteData() {
        let isEnable = MeiJuSetItem.savedEnableValue(EpisodeType.UserCollect)
        if let list = MeiJuDB.getFavoriteEpisodeList(), list.count > 0, isEnable == "1" {
            favoriteList = list
            favoriteView.isHidden = false
            favoriteView.update(with: "收藏", descList: list)
        }
        else {
            favoriteView.isHidden = true
        }
    }
    
    fileprivate func initRecentPlayData() {
        let isEnable = MeiJuSetItem.savedEnableValue(EpisodeType.RecentVisited)
        if let list = MeiJuDB.getRecentPlayEpisodeList(), list.count > 0, isEnable == "1" {
            recentPlayList = list
            recentPlayView.isHidden = false
            recentPlayView.update(with: "最近观看", descList: list)
        }
        else {
            recentPlayView.isHidden = true
        }
    }
    
    // MARK: - utils
    fileprivate func handleSelectItem(_ itemStr: String) {
        self.vc?.searchBarModule?.update(itemStr)
    }
    
    fileprivate func handleFavorite(at index: Int) {
        let item = favoriteList[index]
        gotoEpisodeDetailVC(item)
    }
    
    fileprivate func handleRecentPlay(at index: Int) {
        let item = recentPlayList[index]
        gotoEpisodeDetailVC(item)
    }
    
    fileprivate func gotoEpisodeDetailVC(_ item: MeiJuDBItem) {
        let episodeDetailVC = MeiJuEpisodeSeasonVC()
        episodeDetailVC.episodeId = item.itemId
        episodeDetailVC.episodeTitle = item.title
        self.vc?.navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
    
    // MARK: - action
    
    
    // MARK: - other
    

}
