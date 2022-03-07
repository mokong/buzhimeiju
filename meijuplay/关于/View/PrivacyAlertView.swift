//
//  PrivacyAlertView.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import UIKit

class PrivacyAlertView: UIView {

    // MARK: - properties
    var btnTapped: ((Int) -> Void)?
    var contentTapped: (() -> Void)?
    
    fileprivate var kButtonH: CGFloat = 45.0
    
    fileprivate var titleLabel: UILabel?
    fileprivate var contentLabel: UILabel?
    fileprivate var leftButton: UIButton?
    fileprivate var rightButton: UIButton?
    fileprivate var horizontalLine: UIView?
    fileprivate var verticalLine: UIView?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        layer.cornerRadius = 8.0
        backgroundColor = UIColor.white
        setupLeftBtn()
        setupRightBtn()
        setupTitleLabel()
        setupContentLabel()
        setupHorizontalLine()
        setupVerticalLine()
    }
    
    fileprivate func setupTitleLabel() {
        if titleLabel == nil {
            titleLabel = UILabel()
        }
        titleLabel?.font = UIFont.MWCustomFont.headerFont
        titleLabel?.textColor = UIColor.MWCustomColor.primaryText
        titleLabel?.textAlignment = .center
        addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(12.0)
            make.centerX.equalToSuperview()
        })
    }
    
    fileprivate func setupContentLabel() {
        if contentLabel == nil {
            contentLabel = UILabel()
        }
        contentLabel?.font = UIFont.MWCustomFont.normalFont
        contentLabel?.textColor = UIColor.MWCustomColor.primaryText
        contentLabel?.isUserInteractionEnabled = true
        contentLabel?.numberOfLines = 0
        addSubview(contentLabel!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(contentTappedAction(_:)))
        contentLabel?.addGestureRecognizer(tap)
        
        contentLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(20.0)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel!.snp.bottom).inset(-16.0)
            make.bottom.equalToSuperview().inset(kButtonH+20.0)
        })
    }
    
    fileprivate func setupLeftBtn() {
        if leftButton == nil {
            leftButton = UIButton(type: .custom)
        }
        leftButton?.titleLabel?.font = UIFont.MWCustomFont.normalFont
        leftButton?.setTitleColor(UIColor.MWCustomColor.normalButton, for: .normal)
        leftButton?.addTarget(self, action: #selector(leftBtnAction(_:)), for: .touchUpInside)
        addSubview(leftButton!)
        
        leftButton?.snp.makeConstraints({ make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(kButtonH)
        })
    }
    
    fileprivate func setupRightBtn() {
        if rightButton == nil {
            rightButton = UIButton(type: .custom)
        }
        rightButton?.titleLabel?.font = UIFont.MWCustomFont.headerFont
        rightButton?.setTitleColor(UIColor.MWCustomColor.selectedButton, for: .normal)
        rightButton?.addTarget(self, action: #selector(rightBtnAction(_:)), for: .touchUpInside)
        addSubview(rightButton!)
        
        rightButton?.snp.makeConstraints({ make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(kButtonH)
            make.leading.equalTo(leftButton!.snp.trailing).inset(1.0)
            make.width.equalTo(leftButton!.snp.width)
        })
    }
    
    fileprivate func setupHorizontalLine() {
        if horizontalLine == nil {
            horizontalLine = UIView()
        }
        addSubview(horizontalLine!)
        horizontalLine?.backgroundColor = UIColor.MWCustomColor.line
        
        horizontalLine?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(kButtonH)
            make.height.equalTo(1.0)
        })
    }
    
    fileprivate func setupVerticalLine() {
        if verticalLine == nil {
            verticalLine = UIView()
        }
        addSubview(verticalLine!)
        verticalLine?.backgroundColor = UIColor.MWCustomColor.line
        
        verticalLine?.snp.makeConstraints({ make in
            make.leading.equalTo(leftButton!.snp.trailing)
            make.bottom.equalToSuperview()
            make.height.equalTo(kButtonH)
            make.width.equalTo(1.0)
        })
    }
    
    // MARK: - utils
    func update(title: String, desc: String, highlightStr: String?, leftBtnStr: String, rightBtnStr: String) {
        titleLabel?.text = title
        if highlightStr == nil {
            contentLabel?.text = desc
        }
        else {
            updateContentLabel(desc: desc, highlightStr: highlightStr!)
        }
        leftButton?.setTitle(leftBtnStr, for: .normal)
        rightButton?.setTitle(rightBtnStr, for: .normal)
    }
    
    fileprivate func updateContentLabel(desc: String, highlightStr: String) {
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString(string: desc)
        let range = (desc as NSString).range(of: highlightStr)
        attributedStrM.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.MWCustomColor.hightlightText, range: range)
        contentLabel?.attributedText = attributedStrM
    }
    
    // MARK: - action
    @objc fileprivate func leftBtnAction(_ sender: UIButton) {
        btnTapped?(0)
    }
    
    @objc fileprivate func rightBtnAction(_ sender: UIButton) {
        btnTapped?(1)
    }
    
    @objc fileprivate func contentTappedAction(_ sender: UITapGestureRecognizer) {
        contentTapped?()
    }
    
    // MARK: - other
    

}
