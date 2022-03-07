//
//  EpisodeSeasonSubview.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import UIKit
import SnapKit

class EpisodeSeasonSubview: UIView {

    // MARK: - properties
    var selectItemCallback: ((EpisodeSingleItem) -> Void)?
    
    fileprivate let itemInLine = 5
    fileprivate let itemGap: CGFloat = 12.0
    fileprivate let itemH: CGFloat = 48.0
    fileprivate let tagValue: Int = 900
    
    fileprivate var scrollView: UIScrollView?
    fileprivate var titleLabel: UILabel? // 标题
    fileprivate var contentView: UIView? // 剧集
    fileprivate var dataList: [EpisodeSingleItem] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupScrollView()
        setupTitleLabel()
        setupContentView()
    }
    
    fileprivate func setupScrollView() {
        if scrollView == nil {
            scrollView = UIScrollView(frame: self.bounds)
        }
        scrollView?.delegate = self
        scrollView?.backgroundColor = UIColor.MWCustomColor.lightBackground
        scrollView?.showsVerticalScrollIndicator = false
        addSubview(scrollView!)
        
        scrollView?.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    fileprivate func setupTitleLabel() {
        if titleLabel == nil {
            titleLabel = UILabel()
        }
        titleLabel?.font = UIFont.MWCustomFont.titleFont
        titleLabel?.textColor = UIColor.MWCustomColor.primaryText
        titleLabel?.text = "剧集"
        scrollView?.addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(itemGap)
            make.top.equalToSuperview().inset(16.0)
        }
    }
    
    fileprivate func setupContentView() {
        if contentView == nil {
            contentView = UIView()
        }
        contentView?.backgroundColor = UIColor.MWCustomColor.lightBackground
        contentView?.isUserInteractionEnabled = true
        scrollView?.isUserInteractionEnabled = true
        scrollView?.addSubview(contentView!)
        
        contentView?.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel!.snp.bottom).inset(-16.0)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(self.snp.width)
        })
    }
    
    fileprivate func customButton(_ title: String?, index: Int) -> UIButton {
        let tempButton = UIButton(type: .custom)
        if let value = title {
            var str = value
            if !value.contains("第") {
                str = "第" + value + "集"
            }
            tempButton.setTitle(str, for: .normal)
        }
        tempButton.titleLabel?.font = UIFont.MWCustomFont.normalFont
        update(button: tempButton, isSelected: false)
        tempButton.layer.cornerRadius = 4.0
        tempButton.layer.borderWidth = 0.6
        tempButton.layer.borderColor = UIColor.MWCustomColor.borderLine.cgColor
        tempButton.tag = tagValue + index
        return tempButton
    }
    
    fileprivate func update(button: UIButton, isSelected: Bool) {
        var color = UIColor.MWCustomColor.normalButton
        var borderColor = UIColor.MWCustomColor.borderLine

        if isSelected {
            color = UIColor.MWCustomColor.selectedButton
            borderColor = color
        }
        button.setTitleColor(color, for: .normal)
        button.layer.borderColor = borderColor.cgColor
    }
    
    // MARK: - utils
    func updateContentView(with list: [EpisodeSingleItem]) {
        self.dataList = list
        
        contentView?.removeAllSubviews()
        
        let count = list.count
        let itemW = (MWScreenWidth - itemGap * CGFloat(itemInLine + 1)) / CGFloat(itemInLine)
        var left = itemGap
        var top = 0.0
        for index in 0..<count {
            let row = index % itemInLine // 第一列的第几个
            let column = index / itemInLine // 第几列
            
            top = (itemH + itemGap) * CGFloat(column)
            left = (itemW + itemGap) * CGFloat(row) + itemGap
            
            let item = list[index]
            let btn = customButton(item.zhuti, index: index)
            btn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
            contentView?.addSubview(btn)
            
            btn.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(left)
                make.top.equalToSuperview().inset(top)
                make.width.equalTo(itemW)
                make.height.equalTo(itemH)
            }
            
            if index == 0 && ProjectConsts.shared.isInReview {
                let tagImageView = UIImageView()
                tagImageView.image = UIImage(named: "episode_new")
                contentView?.addSubview(tagImageView)
                
                tagImageView.snp.makeConstraints { make in
                    make.trailing.equalTo(btn.snp.trailing).inset(-10.0)
                    make.top.equalTo(btn.snp.top).inset(-10.0)
                }
            }
        }
        
        top += (itemH + itemGap + itemH)
        scrollView?.contentSize = CGSize(width: MWScreenWidth, height: top)
        
        contentView?.snp.remakeConstraints({ make in
            make.top.equalTo(titleLabel!.snp.bottom).inset(-16.0)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(top)
            make.bottom.equalToSuperview()
            make.width.equalTo(self.snp.width)
        })
    }
    
    func updateSelectState(_ zhuti: String?) {
        guard let targetZhuti = zhuti else {
            return
        }
        
        for subview in contentView!.subviews {
            if let tempButton = subview as? UIButton {
                var tempZhuti: String? = tempButton.currentTitle
                if targetZhuti.contains("集") != true {
                    tempZhuti = tempZhuti?.replacingOccurrences(of: "第", with: "")
                    tempZhuti = tempZhuti?.replacingOccurrences(of: "集", with: "")
                }
                if tempZhuti == targetZhuti {
                    update(button: tempButton, isSelected: true)
                }
                else {
                    update(button: tempButton, isSelected: false)
                }
            }
        }
    }
    
    // MARK: - action
    @objc fileprivate func btnAction(_ sender: UIButton) {
        let index = sender.tag - tagValue
        let item = dataList[index]
        selectItemCallback?(item)
    }
    
    // MARK: - other
    


}

extension EpisodeSeasonSubview: UIScrollViewDelegate {
    
}
