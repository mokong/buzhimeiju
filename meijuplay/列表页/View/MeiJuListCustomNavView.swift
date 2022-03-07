//
//  MeiJuListCustomNavView.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import UIKit
import SnapKit

/// 自定义导航栏
class MeiJuListCustomNavView: UIView {

    // MARK: - properties
    var leftBtnAction: (() -> Void)?
    var rightBtnAction: (() -> Void)?
    
    fileprivate var titleLabel: UILabel?
    fileprivate var leftBtn: UIButton?
    fileprivate var rightBtn: UIButton?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupTitleLabel()
        setupLeftBtn()
        setupRightBtn()
    }
    
    fileprivate func setupTitleLabel() {
        if titleLabel == nil {
            titleLabel = UILabel()
        }
        titleLabel?.font = UIFont.MWCustomFont.titleFont
        titleLabel?.textColor = UIColor.MWCustomColor.whiteText
        titleLabel?.textAlignment = .center
        addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(11.0)
        })
    }
    
    fileprivate func setupLeftBtn() {
        if leftBtn == nil {
            leftBtn = UIButton(type: .custom)
        }
        leftBtn?.setImage(UIImage(named: "nav_folder"), for: UIControl.State.normal)
        addSubview(leftBtn!)
        leftBtn?.addTarget(self, action: #selector(leftBtnTapped(_:)), for: .touchUpInside)
        
        leftBtn?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(0.0)
            make.centerY.equalTo(titleLabel!.snp.centerY)
            make.width.equalTo(64.0)
            make.bottom.equalToSuperview()
        })
    }
    
    fileprivate func setupRightBtn() {
        if rightBtn == nil {
            rightBtn = UIButton(type: .custom)
        }
        rightBtn?.setImage(UIImage(named: "nav_search"), for: .normal)
        addSubview(rightBtn!)
        rightBtn?.addTarget(self, action: #selector(rightBtnTapped(_:)), for: .touchUpInside)
        
        rightBtn?.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(0.0)
            make.centerY.equalTo(titleLabel!.snp.centerY)
            make.width.equalTo(64.0)
            make.bottom.equalToSuperview()
        })
    }
    
    // MARK: - utils
    func update(_ title: String, type: EpisodeType) {
        titleLabel?.text = title
        
        backgroundColor = UIViewController.navBarColor(type)
    }
    
    // MARK: - action
    @objc fileprivate func leftBtnTapped(_ sender: UIButton) {
        leftBtnAction?()
    }
    
    @objc fileprivate func rightBtnTapped(_ sender: UIButton) {
        rightBtnAction?()
    }
    
    // MARK: - other
    

}
