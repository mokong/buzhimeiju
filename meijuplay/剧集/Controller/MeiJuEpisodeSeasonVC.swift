//
//  MeiJuEpisodeSeasonVC.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import UIKit
import Toast_Swift

/// 剧集列表页
class MeiJuEpisodeSeasonVC: MWBaseViewController {

    // MARK: properties
    var episodeTitle: String?
    var episodeId: String?
    private(set) var playModule: MeiJuEpisodePlayModule?
    private(set) var seasonModule: MeiJuEpisodeSeasonModule?
    private(set) var seasonItem: MeiJuEpisodeSeasonItem?
    
    private(set) var historyPlayedItem: MeiJuDBItem?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.title = episodeTitle
        
        setupRightBarButtonItem()
        setupSubModules()
        requestEpisodeDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if MWPlayerUtil.sharedInstance.player != nil { // 有播放的，界面消失时，存储一下播放进度
            let currentTime = MWPlayerUtil.sharedInstance.player?.currentTime
            saveEpisodePlayInfo(playModule?.playItem, seasonItem: seasonItem, currentTime: currentTime)
        }
    }
    
    deinit {
        MWPlayerUtil.sharedInstance.releasePlayer()
    }
    
    // MARK: - init
    fileprivate func setupRightBarButtonItem() {
        let isFavorite = MeiJuDB.isFavorite(episodeId ?? "")
        let image = getFavoriteImage(isFavorite)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                                 style: UIBarButtonItem.Style.plain,
                                                                 target: self,
                                                                 action: #selector(handleFavorite(_:)))
    }
    
    fileprivate func getFavoriteImage(_ isFavorite: Bool) -> UIImage? {
        var image = UIImage(named: "nav_favorite")
        if isFavorite {
            image = UIImage(named: "nav_favorite_select")
        }
        return image
    }
    
    fileprivate func setupSubModules() {
        setupPlayModule()
        setupSeasonModule()
    }
    
    fileprivate func setupPlayModule() {
        if playModule == nil {
            playModule = MeiJuEpisodePlayModule(self)
        }
        playModule?.install()
        
        MWPlayerUtil.sharedInstance.playerEndCallback = { [weak self] currentTime in
            self?.saveEpisodePlayInfo(self?.playModule?.playItem, seasonItem: self?.seasonItem, currentTime: currentTime)
        }
    }
    
    fileprivate func setupSeasonModule() {
        if seasonModule == nil {
            seasonModule = MeiJuEpisodeSeasonModule(self)
        }
        seasonModule?.install()
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    @objc fileprivate func handleFavorite(_ sender: UIBarButtonItem) {
        let dbItem = generateDBItem()
        
        let itemId = episodeId ?? ""
        let isFavorite = MeiJuDB.isFavorite(itemId)
        var toastMsg = ""
        if isFavorite {
            toastMsg = "已取消收藏"
            MeiJuDB.deleteFavoriteEpisode(itemId)
        }
        else {
            toastMsg = "已收藏"
            MeiJuDB.saveFavoriteEpisode(item: dbItem)
        }
        self.view.hideToast()
        self.view.makeToast(toastMsg, duration: 1.5, position: .center, title: nil, image: nil, style: ToastStyle(), completion: nil)

        let image = getFavoriteImage(!isFavorite)
        self.navigationItem.rightBarButtonItem?.image = image
    }
    
    // MARK: - request
    fileprivate func requestEpisodeDetail() {
        let iid = episodeId ?? ""
        MeiJuAPIManager.shared.episodeDetailRequest(with: iid) { [weak self] seasonItem in
            self?.seasonItem = seasonItem
            self?.playModule?.reloadData()
            self?.seasonModule?.reloadData()
            self?.handleHistoryPlayedEpisodeInfo()
        }
    }
    
    // MARK: - other
    func handleHistoryPlayedEpisodeInfo() {
        if let item = getHistoryPlayedEpisodeInfo() {
            // 不为空，说明有记录
            self.historyPlayedItem = item
                
            /// 更新剧集列表高亮
            self.seasonModule?.updateEpisodeListHighlightDisplay(with: item)
        }
    }
    
    fileprivate func getHistoryPlayedEpisodeInfo() -> MeiJuDBItem? {
        let itemId = episodeId ?? ""
        if itemId.count == 0 {
            return nil
        }
        
        let item = MeiJuDB.getHistoryPlayEpisodeInfo(with: itemId)
        return item
    }

    func saveRecentPlayEpisode() {
        let dbItem = generateDBItem()
        MeiJuDB.saveRecentPlayEpisode(item: dbItem)
    }
    
    func saveEpisodePlayInfo(_ item: EpisodeSingleItem?, seasonItem: MeiJuEpisodeSeasonItem?, currentTime: TimeInterval?) {
        let dbItem = generateDBItem()
        dbItem.bofang = item?.bofang
        dbItem.episodeZhuTi = item?.zhuti
        if let currentTime = currentTime {
            dbItem.playDuration = String(format: "%f", currentTime)
        }
        
        if let itemId = seasonItem?.iid { // 先删除之前的，再存储新的
            MeiJuDB.delegetPlayEpisodeInfo(with: itemId)
        }
        
        MeiJuDB.save(item: dbItem)
    }
    
    func generateDBItem() -> MeiJuDBItem {
        let dbItem = MeiJuDBItem()
        dbItem.title = episodeTitle ?? ""
        dbItem.itemId = episodeId ?? ""
        dbItem.img = seasonItem?.img
        return dbItem
    }

}
