//
//  MeiJuHomeModule.swift
//  meijuplay
//
//  Created by Horizon on 13/12/2021.
//

import Foundation
import UIKit
import SnapKit

class MeiJuHomeModule {
    // MARK: - properties
    private(set) lazy var view: MeiJuHomeView = MeiJuHomeView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: MWScreenHeight))
    private weak var vc: MeiJuHomeVC?
    
    // MARK: - init
    init(_ vc: MeiJuHomeVC) {
        self.vc = vc
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.selectItemCallback = { [weak self] item in
            self?.handleSelectItemAction(item)
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    fileprivate func handleSelectItemAction(_ item: MeiJuItem) {
//        let playerVC = MWPlayerVC()
//        self?.vc?.navigationController?.pushViewController(playerVC, animated: true)
        
        let setVC = MeiJuSetController()
        self.vc?.navigationController?.pushViewController(setVC, animated: true)
    }
    
    // MARK: - other
    

    // MARK: - Request
    func initData() {
        MeiJuAPIManager.shared.homepageRequest { resItem in
            guard let item = resItem else { return }

            let list = item.formatToDisplayDataList()
            self.view.updateViews(with: list)
        }
    }
}
