//
//  MeiJuSearchSuggestView.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import UIKit
import SnapKit

/// 推荐
class MeiJuSearchSuggestView: UIView {

    // MARK: - properties
    var selectItemCallback: ((AnyObject, Int) -> Void)?
    
    fileprivate var headerLabel: UILabel?
    fileprivate var bodyView: UIView?
    fileprivate let kHorizontalSpace: CGFloat = 16.0
    fileprivate let kTagValue: Int = 900
    fileprivate var descList: [AnyObject] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupHeaderLabel()
        setupBodyView()
    }
    
    fileprivate func setupHeaderLabel() {
        if headerLabel == nil {
            headerLabel = UILabel()
        }
        addSubview(headerLabel!)
        headerLabel?.font = UIFont.MWCustomFont.normalFont
        headerLabel?.textColor = UIColor.MWCustomColor.secondaryText
        
        headerLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(kHorizontalSpace)
            make.top.trailing.equalToSuperview()
        })
    }
    
    fileprivate func setupBodyView() {
        if bodyView == nil {
            bodyView = UIView()
        }
        addSubview(bodyView!)
        
        bodyView?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel!.snp.bottom)
        })
    }
    
    // MARK: - utils
    func update(with title: String?, descList: [AnyObject]) {
        headerLabel?.text = title
        self.descList = descList
        
        setupBodySubviews(descList)
    }
    
    fileprivate func setupBodySubviews(_ descList: [AnyObject]) {
        bodyView?.removeAllSubviews()
        
        let totalW = MWScreenWidth - kHorizontalSpace * 2.0
        let buttonH: CGFloat = 38.0
        var top: CGFloat = 0.0
        var leftSpace: CGFloat = kHorizontalSpace
        
        for index in 0..<descList.count {
            let item = descList[index]
            var itemStr = ""
            if let tempStr = item as? String {
                itemStr = tempStr
            }
            else if let tempDBItem = item as? MeiJuDBItem {
                itemStr = tempDBItem.title ?? ""
            }
            let tempButton = customButton(itemStr)
            bodyView?.addSubview(tempButton)
            tempButton.tag = kTagValue + index
            let buttonW = itemStr.getStrWidth(height: 18.0, font: tempButton.titleLabel!.font) + 20.0
            if leftSpace + buttonW > totalW {
                // 超出一行间距，则需要换行
                top = top + buttonH + 8.0
                leftSpace = kHorizontalSpace
            }
            
            tempButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(leftSpace)
                make.top.equalToSuperview().inset(top)
                make.height.equalTo(buttonH)
                make.width.equalTo(buttonW)
            }
            
            leftSpace = leftSpace + buttonW + kHorizontalSpace
        }
        
        let height = top + buttonH + 8.0
        bodyView?.snp.remakeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(headerLabel!.snp.bottom).inset(-8.0)
            make.height.equalTo(height)
            make.bottom.equalToSuperview()
        })
    }
    
    fileprivate func customButton(_ title: String) -> UIButton {
        let tempButton = UIButton(type: .custom)
        tempButton.titleLabel?.font = UIFont.MWCustomFont.descFont
        tempButton.setTitle(title, for: .normal)
        tempButton.setTitleColor(UIColor.MWCustomColor.secondaryButton, for: .normal)
        tempButton.backgroundColor = UIColor.MWCustomColor.buttonBackground
        tempButton.layer.cornerRadius = 6.0
        tempButton.addTarget(self, action: #selector(customBtnAction(_:)), for: .touchUpInside)
        return tempButton
    }
    
    // MARK: - action
    @objc fileprivate func customBtnAction(_ sender: UIButton) {
        let index = sender.tag - kTagValue
        if index < descList.count {
            let item = descList[index]
            selectItemCallback?(item, index)
        }
    }
    
    // MARK: - other
    

}
