//
//  MeiJuListView.swift
//  meijuplay
//
//  Created by Horizon on 20/12/2021.
//

import UIKit
import MJRefresh

class MeiJuListView: UIView {

    // MARK: properties
    var navLeftBtnAction: (() -> Void)?
    var navRightBtnAction: (() -> Void)?
    var selectItemCallback: ((MeiJuItem) -> Void)?
    var pulldownRefreshCallback: (() -> Void)?
    var pullupLoadMoreCallback: (() -> Void)?
        
    fileprivate let kLineSpacing: CGFloat = 12.0 // 纵向间距
    fileprivate let kItemSpacing: CGFloat = 10.0 // 横向间距
    fileprivate let kItemInLine: Int = 3
    fileprivate let kHorizontalMargin: CGFloat = 16.0
    
    fileprivate var navView: MeiJuListCustomNavView?
    fileprivate var collectionView: UICollectionView?
    fileprivate var dataList: [MeiJuItem] = []
    

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupNavView()
        setupCollectionView()
        setupCollectionViewHeader()
        setupCollectionViewFooter()
    }
    
    fileprivate func setupNavView() {
        let height = UIDevice.navigationBarH()
        if navView == nil {
            navView = MeiJuListCustomNavView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: height))
        }
        addSubview(navView!)
        
        navView?.leftBtnAction = { [weak self] in
            self?.navLeftBtnAction?()
        }
        
        navView?.rightBtnAction = { [weak self] in
            self?.navRightBtnAction?()
        }
        
        navView?.snp.makeConstraints({ make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(height)
        })
    }
    
    fileprivate func setupCollectionView() {
        if collectionView == nil {
            let collectionLayout = collectionViewLayout()
            collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: collectionLayout)
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView?.showsVerticalScrollIndicator = false
            collectionView?.backgroundColor = UIColor.custom.background
            collectionView?.register(MeiJuHomeCell.self, forCellWithReuseIdentifier: MeiJuHomeCell.reuseId())
            collectionView?.register(MeiJuListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MeiJuListHeaderView.reuseId())
        }
        addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(navView!.snp.bottom)
        })
    }
    
    fileprivate func setupCollectionViewHeader() {
        collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.pulldownRefreshCallback?()
        })
    }
    
    fileprivate func setupCollectionViewFooter() {
        collectionView?.mj_footer = MJRefreshAutoFooter(refreshingBlock: { [weak self] in
            self?.pullupLoadMoreCallback?()
        })
    }
    
    // MARK: action



    // MARK: utils
    fileprivate func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = kLineSpacing
        flowLayout.minimumInteritemSpacing = kItemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: 0.0, left: kHorizontalMargin, bottom: 0.0, right: kHorizontalMargin)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }
    
    func updateNavView(with title: String, type: EpisodeType) {
        navView?.update(title, type: type)
    }

    func updateViews(with list: [MeiJuItem]) {
        self.dataList = list
        self.collectionView?.reloadData()
    }
    
    func updateWithEmptyView() {
        
    }
    
    func endRefreshing() {
        collectionView?.mj_header?.endRefreshing()
        collectionView?.mj_footer?.endRefreshing()
    }
    
    func endRefreshingWithNoMoreData() {
        collectionView?.mj_footer?.endRefreshingWithNoMoreData()
    }
    
    func scrollToTop() {
        collectionView?.setContentOffset(CGPoint.zero, animated: false)
    }

    // MARK: other

}

extension MeiJuListView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gapSpace = kHorizontalMargin * 2.0 + kItemSpacing * CGFloat(kItemInLine - 1)
        let width = (MWScreenWidth - gapSpace) / CGFloat(kItemInLine) - 0.5
        let height = width / 0.7 + 4.0 + 18.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = MWScreenWidth
        let height = kLineSpacing
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MeiJuListHeaderView.reuseId(), for: indexPath) as? MeiJuListHeaderView
            if let view = reusableView {
                return view
            }
        }
        let reusableView: UICollectionReusableView = UICollectionReusableView()
        return reusableView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeiJuHomeCell.reuseId(), for: indexPath) as? MeiJuHomeCell
        if cell == nil {
            cell = MeiJuHomeCell()
        }
        cell?.setupSubviews()
        let item = item(at: indexPath)
        cell?.updateSubviews(with: item.title, imageUrl: item.img)
        
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = item(at: indexPath)
        selectItemCallback?(item)
    }
    
    fileprivate func item(at indexPath: IndexPath) -> MeiJuItem {
        let rowNum = indexPath.row
        var item = dataList[rowNum]
        if let imgStr = item.img, imgStr.hasPrefix("http") == true {
            return item
        }
        if rowNum - 1 > 0 {
            let previousItem = dataList[rowNum - 1]
            item.img = previousItem.img
        }
        else if (rowNum + 1) < (dataList.count - 1) {
            let nextItem = dataList[rowNum + 1]
            item.img = nextItem.img
        }
        return item
    }
}
