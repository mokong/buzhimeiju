//
//  MeiJuEpisodePlayModule.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import Foundation
import UIKit
import SnapKit
import CoreMedia

class MeiJuEpisodePlayModule {
    // MARK: - properties

    private(set) weak var vc: MeiJuEpisodeSeasonVC?
    private(set) lazy var view = EpisodeSeasonPlayView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: kPlayerViewH))
    private(set) var playItem: EpisodeSingleItem?
    
    // MARK: - init
    init(_ vc: MeiJuEpisodeSeasonVC) {
        self.vc = vc
        self.vc?.view.addSubview(view)
        
        view.playBtnCallback = { [weak self] in
            self?.handlePlayBtnAction()
        }
    }
    
    func install() {
        let navigationBarH = vc!.topBarHeight
        view.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(navigationBarH)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(kPlayerViewH)
        })
    }
    
    // MARK: - utils
    func reloadData() {
        self.view.update(with: vc?.seasonItem?.img)
    }
    
    // MARK: - action
    fileprivate func handlePlayBtnAction() {
        // 点击播放按钮
        // 播放最新一集，后续修改为根据数据库历史播放记录来
        var playItem: EpisodeSingleItem?
        if let historyPlayedItem = self.vc?.historyPlayedItem {
            playItem = EpisodeSingleItem()
            playItem?.zhuti = historyPlayedItem.episodeZhuTi
            playItem?.bofang = historyPlayedItem.bofang
            playItem?.weburl = historyPlayedItem.bofang
        }
        
        if playItem == nil {
            playItem = self.vc?.seasonItem?.list?.first
        }
        
        guard let item = playItem else {
           return
        }
        
        play(with: item)
    }
    
    func play(with item: EpisodeSingleItem?) {
        if ProjectConsts.shared.isInReview {
            self.vc?.view.makeToast("不支持播放噢，请去官方平台观看", point: self.vc!.view.center, title: nil, image: nil, completion: nil)
            return
        }
        
        guard let bofang = item?.bofang,
              let zhuti = item?.zhuti else {
                return
        }
        
        playItem = item
        
        if let url = URL(string: bofang) {
            MWPlayerUtil.sharedInstance.playEmbeddedVideo(url: url, embeddedContentView: view, userInfo: nil)
            
            self.vc?.saveRecentPlayEpisode()
            
            if self.vc?.historyPlayedItem?.episodeZhuTi == zhuti {
                // 说明播放的是历史Item
                if let timeStr = self.vc?.historyPlayedItem?.playDuration,
                   let time = timeStr.double() {
                    MWPlayerUtil.sharedInstance.seekToTime(time)
                }
            }
        }
    }
    
    // MARK: - other
    

}
