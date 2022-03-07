//
//  MWDevOtherAppsModule.swift
//  meijuplay
//
//  Created by Horizon on 25/2/2022.
//

import Foundation
import UIKit

class MWDevOtherAppsModule {
    // MARK: - properties
    private(set) weak var vc: MWDevOtherAppsVC?
    private(set) lazy var view = MWDevOtherAppsView(frame: .zero)
    
    // MARK: - init
    init(_ vc: MWDevOtherAppsVC) {
        self.vc = vc
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.selectItemCallback = { [weak self] type in
            self?.handleSelectItem(type)
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func initData() {
        let watermarkType = MWDevAppType.watermarkCamera
        let game24Type = MWDevAppType.game24
        self.view.update([watermarkType, game24Type])
    }
    
    // MARK: - utils
    fileprivate func handleSelectItem(_ type: MWDevAppType) {
        let urlString = String(format: "https://apps.apple.com/cn/app/qq/id%@", type.getAppId())
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:],completionHandler: {(success) in})
        }
    }
    
    // MARK: - action
    
    
    // MARK: - other
    
}
