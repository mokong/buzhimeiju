//
//  MeiJuSearchContentViewModule.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import Foundation
import SnapKit
import Toast_Swift

class MeiJuSearchContentViewModule {
    // MARK: - properties
    fileprivate weak var vc: MeiJuSearchVC?
    fileprivate lazy var view = MeiJuSearchContentView(frame: .zero)
    fileprivate var dataList: [SearchSingleItem] = []
    
    // MARK: - init
    init(_ vc: MeiJuSearchVC) {
        self.vc = vc
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.selectItemCallback = { [weak self] item in
            self?.handleSelectItem(item)
        }
    }
    
    func install() {
        view.isHidden = true
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(vc!.searchBarModule!.view.snp.bottom).inset(-28.0)
            make.bottom.equalToSuperview()
        }
    }
    
    func update() {
        view.isHidden = false
        self.vc?.view.bringSubviewToFront(view)
        view.updateViews(with: self.dataList)
    }
    
    // MARK: - utils
    fileprivate func handleSelectItem(_ item: SearchSingleItem) {
        let episodeDetailVC = MeiJuEpisodeSeasonVC()
        episodeDetailVC.episodeId = item.itemId
        episodeDetailVC.episodeTitle = item.title
        self.vc?.navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
    
    fileprivate func gotoPlayerVC(_ string: String) {
        let playerVC = MWPlayerVC()
        playerVC.inputStr = string
        self.vc?.navigationController?.pushViewController(playerVC, completion: nil)
    }
    
    // MARK: - action
    
    
    // MARK: - other
    
    
    
    // MARK: - request
    func search(with str: String) {
        if str.count == 0 {
            view.isHidden = true
            return
        }
        
        if str == "在线播放器" || str.contains("https://") {
            gotoPlayerVC(str)
            return
        }
        
        view.isHidden = false
        
        self.view.makeToastActivity(.center)
        MeiJuAPIManager.shared.searchEpisodeRequest(with: str) { [weak self] resItem in
            self?.view.hideToastActivity()
            guard let list = resItem?.list else {
                return
            }
            
            self?.dataList = list
            self?.update()
        }
    }
}
