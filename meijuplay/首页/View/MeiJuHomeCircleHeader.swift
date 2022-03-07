//
//  MeiJuHomeCircleHeader.swift
//  meijuplay
//
//  Created by Horizon on 13/12/2021.
//

import UIKit

class MeiJuHomeCircleHeader: UICollectionReusableView {
    // MARK: - view life cycle
    var tappedCallback: ((MeiJuItem) -> Void)?
    
    fileprivate let circleH: CGFloat = 200.0
    fileprivate let titleH: CGFloat = 56.0
    
    fileprivate var scrollView: UIScrollView?
    fileprivate var currentPageIndex: Int = 0
    fileprivate var pageControl: UIPageControl?
    fileprivate var timer: Timer?
    fileprivate var titleLabel: UILabel?
    
    fileprivate lazy var dataArray: [MeiJuItem] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        isUserInteractionEnabled = true
        
        setupScrollView()
        setupPageControl()
        setupTimer()
        setupHeaderTitle()
    }
    
    fileprivate func setupScrollView() {
        if scrollView == nil {
            scrollView = UIScrollView(frame: bounds)
            scrollView?.showsHorizontalScrollIndicator = false
            scrollView?.delegate = self
            scrollView?.isPagingEnabled = true
            scrollView?.isScrollEnabled = true
            scrollView?.bounces = false
        }
        addSubview(scrollView!)
        
        scrollView?.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self)
            make.width.equalTo(bounds.width)
            make.height.equalTo(circleH)
        }
    }
    
    fileprivate func setupHeaderTitle() {
        if titleLabel == nil {
            titleLabel = UILabel()
        }
        titleLabel?.font = UIFont.custom.titleFont
        titleLabel?.textColor = UIColor.custom.primaryText
        addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(32.0)
            make.top.equalTo(self.scrollView!.snp.bottom)
            make.bottom.equalToSuperview()
        })
    }
    
    fileprivate func setupPageControl() {
        let pageControlH = 25.0
        if pageControl == nil {
            pageControl = UIPageControl(frame: CGRect.zero)
        }
        addSubview(pageControl!)
        
        pageControl?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.scrollView!.snp.bottom).inset(-12.0)
            make.height.equalTo(pageControlH)
        });
    }
    
    func setupTimer() {
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction(_:)), userInfo: nil, repeats: true)
            RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    // MARK: - utils
    func updateList(with list: [MeiJuItem]?, title: String?) {
        guard let array = list, array.count > 0 else {
            return
        }
        
        setupSubviews()
        
        self.dataArray = array
        // 把第一个插到倒数第一
        // 把倒数第一个插到第一
        self.dataArray.insert(array[array.count-1], at: 0)
        self.dataArray.insert(array[0], at: self.dataArray.count-1)
        
        // 更新 pageControl 的个数
        self.pageControl?.numberOfPages = array.count
        
        // 刷新 ScrollView 的 Subview
        reloadScrollViewSubviews()
        
        titleLabel?.text = title
    }
    
    fileprivate func reloadScrollViewSubviews() {
        scrollView?.removeAllSubviews()
        
        guard let tempScrollView = scrollView else {
            return
        }
        
        let imageViewW = MWScreenWidth
        var leftSpace = 0.0

        for item in dataArray {
            let singleView = MeiJuHomeSingleCircleView()
            singleView.isUserInteractionEnabled = true
            tempScrollView.addSubview(singleView)
            
            singleView.update(with: item.img, text: item.title)
            singleView.tapCallback = { [weak self] in
                self?.tappedCallback?(item)
            }
            
            singleView.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(leftSpace)
                make.top.bottom.equalToSuperview()
                make.width.equalTo(imageViewW)
            }
            leftSpace += imageViewW
        }
        
        leftSpace = leftSpace - imageViewW
        tempScrollView.contentSize = CGSize(width: leftSpace, height: self.bounds.size.height)
    }
    
    // MARK: - action
    @objc fileprivate func timerAction(_ sender: Timer) {
        guard let tempScrollView = scrollView else {
            return
        }
        // 设置滚动
        let scrollViewW = tempScrollView.bounds.size.width
        let offsetX = tempScrollView.contentOffset.x
        
        let page = floor((offsetX - scrollViewW)/2.0)/scrollViewW + 1.0
        currentPageIndex = Int(page) + 1
        
        if (currentPageIndex > 0) && (currentPageIndex < dataArray.count) {
            let x = CGFloat(currentPageIndex) * scrollViewW
            UIView.animate(withDuration: 0.3) {
                tempScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: false)
            }
            
            if currentPageIndex == dataArray.count - 1 {
                currentPageIndex += 1
            }
        }
        
        if (currentPageIndex == self.dataArray.count) {
            tempScrollView.setContentOffset(CGPoint(x: scrollViewW, y: 0), animated: false)
        }
        
        if currentPageIndex == 0 {
            let targetX = CGFloat(self.dataArray.count - 2) * scrollViewW
            tempScrollView.setContentOffset(CGPoint(x: targetX, y: 0), animated: false)
        }
    }
    
    // MARK: - other
    class func reuseId() -> String {
        return "MeiJuHomeCircleHeader"
    }
}

extension MeiJuHomeCircleHeader: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setupTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollViewW = scrollView.bounds.size.width
        let offsetX = scrollView.contentOffset.x
        
        let tempValue = Int(offsetX / scrollViewW + 0.5)
        let page = tempValue % self.dataArray.count
        
        currentPageIndex = page
        pageControl?.currentPage = page - 1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewW = scrollView.bounds.size.width
        if currentPageIndex == 0 {
            let targetX = CGFloat(self.dataArray.count - 2) * scrollViewW
            scrollView.setContentOffset(CGPoint(x: targetX, y: 0), animated: false)
        }
        else if (currentPageIndex == (self.dataArray.count - 1)) {
            scrollView.setContentOffset(CGPoint(x: scrollViewW, y: 0), animated: false)
        }
    }
}
