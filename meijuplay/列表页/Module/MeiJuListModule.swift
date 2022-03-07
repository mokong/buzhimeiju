//
//  MeiJuListModule.swift
//  meijuplay
//
//  Created by Horizon on 20/12/2021.
//

import Foundation
import UIKit
import SnapKit
import Toast_Swift

class MeiJuListModule {
    // MARK: - properties
    private(set) lazy var view: MeiJuListView = MeiJuListView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: MWScreenHeight))
    private weak var vc: MeiJuListVC?
    private var pageNum: Int = 1 // 当前加载第几页
    private var canLoadMore: Bool = true // 是否可以加载更多
    private var dataList: [MeiJuItem] = []
    
    // MARK: - init
    init(_ vc: MeiJuListVC) {
        self.vc = vc
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.navLeftBtnAction = { [weak self] in
            self?.handleNavLeftAction()
        }
        
        view.navRightBtnAction = { [weak self] in
            self?.handleNavRightAction()
        }
        
        view.selectItemCallback = { [weak self] item in
            self?.handleSelectItemAction(item)
        }
        
        view.pulldownRefreshCallback = { [weak self] in
            self?.handlePulldownRefreshAction()
        }
        
        view.pullupLoadMoreCallback = { [weak self] in
            self?.handlePullupLoadMoreAction()
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(MWScreenWidth)
            make.leading.equalTo(self.vc!.leftModule!.view.snp.trailing)
        }
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    fileprivate func handleNavLeftAction() {
        vc?.menuBarItemAction()
    }
    
    fileprivate func handleNavRightAction() {
        vc?.searchBarItemAction()
    }
    
    fileprivate func handleSelectItemAction(_ item: MeiJuItem) {
//        let playerVC = MWPlayerVC()
//        self?.vc?.navigationController?.pushViewController(playerVC, animated: true)
        let episodeDetailVC = MeiJuEpisodeSeasonVC()
        episodeDetailVC.episodeId = item.itemId
        episodeDetailVC.episodeTitle = item.title
        self.vc?.navigationController?.pushViewController(episodeDetailVC, animated: true)
    }
    
    fileprivate func handlePulldownRefreshAction() {
        self.canLoadMore = true
        self.pageNum = 1
        initData(with: false)
    }
    
    fileprivate func handlePullupLoadMoreAction() {
        if self.canLoadMore != true {
            return
        }
        
        self.pageNum += 1
        initData(with: false)
    }
    
    func scrollToTop() {
        view.scrollToTop()
    }
    
    // MARK: - other
    

    // MARK: - Request
    func initData(with loading: Bool = false) {
        if loading {
            self.pageNum = 1
            self.dataList = []
            
            self.view.makeToastActivity(UIScreen.main.bounds.center)
            
            let navTitle = ProjectConsts.shared.navTitle()
            let selectType = ProjectConsts.shared.selectType
            self.view.updateNavView(with: navTitle, type: selectType)
        }
        
        let type = ProjectConsts.shared.selectType
        MeiJuAPIManager.shared.episodeListRequest(pageNum: pageNum, typeStr: type.rawValue) { resItem in
            self.view.hideToastActivity()            
            guard let itemList = resItem?.list, itemList.count > 0 else {
                self.canLoadMore = false
                self.view.endRefreshing()
                self.view.endRefreshingWithNoMoreData()
                if self.dataList.count == 0 {
                    self.view.updateWithEmptyView()
                }
                return
            }

            self.canLoadMore = true
            
            if self.pageNum == 1 {
                self.dataList = itemList
            }
            else {
                self.dataList.append(contentsOf: itemList)
            }
            self.view.updateViews(with: self.dataList)
            self.view.endRefreshing()
        }
    }

}
