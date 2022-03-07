//
//  MWPlayerViewModule.swift
//  meijuplay
//
//  Created by Horizon on 31/12/2021.
//

import Foundation
import SnapKit
import UIKit

class MWPlayerViewModule {
    // MARK: - properties
    private(set) weak var vc: MWPlayerVC?
    private(set) lazy var view = MWPlayerView(frame: CGRect.zero)
    
    // MARK: - init
    init(_ vc: MWPlayerVC) {
        self.vc = vc
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.handlePlayAction = { [weak self] urlStr in
            self?.handlePlay(with: urlStr)
        }
    }
    
    func install() {
        let navigationBarH = vc!.topBarHeight
        view.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(navigationBarH)
            make.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    func initData(with inputStr: String?) {
        if let tempStr = inputStr, tempStr.contains("http") == true {
            view.update(with: tempStr)
            handlePlay(with: tempStr)
        }
    }
    
    // MARK: - utils

    
    fileprivate func handlePlay(with urlStr: String) {
        if let url = URL(string: urlStr) {
            MWPlayerUtil.sharedInstance.playEmbeddedVideo(url: url, embeddedContentView: view.playBackView!, userInfo: nil)
        }
    }
    
    // MARK: - action
    
    
    // MARK: - other
    

}
