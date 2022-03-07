//
//  MeiJuSearchContentView.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import UIKit

class MeiJuSearchContentView: UIView {

   
    // MARK: properties
    var selectItemCallback: ((SearchSingleItem) -> Void)?
        
    fileprivate let kLineSpacing: CGFloat = 12.0 // 纵向间距
    fileprivate let kItemSpacing: CGFloat = 10.0 // 横向间距
    fileprivate let kItemInLine: Int = 3
    fileprivate let kHorizontalMargin: CGFloat = 16.0
    
    fileprivate var collectionView: UICollectionView?
    fileprivate var dataList: [SearchSingleItem] = []
    

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
            collectionView?.register(MeiJuListHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MeiJuListHeaderView.reuseId())
            collectionView?.keyboardDismissMode = .interactive
        }
        addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints({ make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview()
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

    func updateViews(with list: [SearchSingleItem]) {
        self.dataList = list
        self.collectionView?.reloadData()
    }
    
    func updateWithEmptyView() {
        
    }


}


extension MeiJuSearchContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    
    fileprivate func item(at indexPath: IndexPath) -> SearchSingleItem {
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
