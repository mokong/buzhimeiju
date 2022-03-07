//
//  MeiJuHomeView.swift
//  meijuplay
//
//  Created by MorganWang on 2021/11/28.
//

import UIKit

class MeiJuHomeView: UIView {

    // MARK: properties
    var selectItemCallback: ((MeiJuItem) -> Void)?
    
    fileprivate let kCollectionHeaerH: CGFloat = 200.0
    fileprivate let kTitleH = 56.0
    
    fileprivate let kItemH: CGFloat = 167.0
    fileprivate let kLineSpacing: CGFloat = 8.0
    fileprivate let kItemSpacing: CGFloat = 12.0
    fileprivate let kItemInLine: Int = 3
    fileprivate let kHorizontalMargin: CGFloat = 16.0
    
    fileprivate var headerView: MeiJuHomeHeaderView?
    fileprivate var collectionView: UICollectionView?
    fileprivate var dataList: [MeiJuHomeDataItem] = []
    

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupCollectionView()
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
            collectionView?.register(MeiJuHomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MeiJuHomeHeaderView.reuseId())
            collectionView?.register(MeiJuHomeCircleHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MeiJuHomeCircleHeader.reuseId())
        }
        addSubview(collectionView!)
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

    func updateViews(with list: [MeiJuHomeDataItem]) {
        self.dataList = list
        self.collectionView?.reloadData()
    }

    // MARK: other


}

extension MeiJuHomeView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let list = dataList[section].list
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = MWScreenWidth
        let height = kTitleH
        if section == 0 {
            return CGSize(width: width, height: height + kCollectionHeaerH)
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let item = self.dataList[indexPath.section]
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MeiJuHomeCircleHeader.reuseId(), for: indexPath) as? MeiJuHomeCircleHeader
                reusableView?.tappedCallback = { [weak self] (item) in
                    self?.selectItemCallback?(item)
                }
                reusableView?.updateList(with: item.list, title: item.typeTitle)
                if let view = reusableView {
                    return view
                }
            }
            else {
                let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MeiJuHomeHeaderView.reuseId(), for: indexPath) as? MeiJuHomeHeaderView
                reusableView?.update(with: item.typeTitle)
                if let view = reusableView {
                    return view
                }
            }
        }

        let reusableView: UICollectionReusableView = UICollectionReusableView()
        return reusableView
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gapSpace = kHorizontalMargin * 2.0 + kItemSpacing * CGFloat(kItemInLine - 1)
        let width = (MWScreenWidth - gapSpace) / CGFloat(kItemInLine)
        let height = kItemH
        return CGSize(width: width, height: height)
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
        let list = dataList[indexPath.section].list
        let item = list[indexPath.row]
        return item
    }
}
