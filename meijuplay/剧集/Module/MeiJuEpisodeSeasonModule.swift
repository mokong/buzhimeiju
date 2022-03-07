//
//  MeiJuEpisodeSeasonModule.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import Foundation
import SnapKit

class MeiJuEpisodeSeasonModule {
    // MARK: - properties
    private(set) weak var vc: MeiJuEpisodeSeasonVC?
    private(set) lazy var view = EpisodeSeasonSubview(frame: CGRect.zero)
    private(set) var selectZhuti: String?
    
    // MARK: - init
    init(_ vc: MeiJuEpisodeSeasonVC) {
        self.vc = vc
        self.vc?.view.addSubview(view)
        
        view.selectItemCallback = { [weak self] item in
            self?.handleSelectItem(item)
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(self.vc!.playModule!.view.snp.bottom)
        }
    }
    
    // MARK: - utils
    func reloadData() {
        guard let list = vc?.seasonItem?.list else {
            return
        }
        view.updateContentView(with: list)
    }
    
    
    func updateEpisodeListHighlightDisplay(with item: MeiJuDBItem?) {
        guard let historyZhuti = item?.episodeZhuTi else {
            return
        }
        
        view.updateSelectState(historyZhuti)
    }
    
    // MARK: - action
    fileprivate func handleSelectItem(_ item: EpisodeSingleItem) {
        self.selectZhuti = item.zhuti
        view.updateSelectState(item.zhuti)
        vc?.playModule?.play(with: item)
    }
    
    // MARK: - other
    

}
