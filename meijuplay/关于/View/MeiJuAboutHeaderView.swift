//
//  MeiJuAboutHeaderView.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import UIKit
import SnapKit

class MeiJuAboutHeaderView: UIView {
    // MARK: - properties
    fileprivate var displayImageView: UIImageView?
    fileprivate var displayLabel: UILabel?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        backgroundColor = UIColor.MWCustomColor.lightBackground
        setupDisplayImageView()
        setupDisplayLabel()
    }
    
    fileprivate func setupDisplayImageView() {
        if displayImageView == nil {
            displayImageView = UIImageView()
        }
        addSubview(displayImageView!)
        
        displayImageView?.image = UIImage(named: "app_icon")
        displayImageView?.layer.cornerRadius = 8.0
        displayImageView?.clipsToBounds = true
        
        displayImageView?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20.0)
            make.width.height.equalTo(60.0)
        })
    }
    
    fileprivate func setupDisplayLabel() {
        if displayLabel == nil {
            displayLabel = UILabel()
        }
        addSubview(displayLabel!)
        
        displayLabel?.font = UIFont.MWCustomFont.descFont
        displayLabel?.textColor = UIColor.MWCustomColor.secondaryText
        displayLabel?.textAlignment = .center
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        displayLabel?.text = appVersion
        
        displayLabel?.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(displayImageView!.snp.bottom).inset(-12.0)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayImageView?.layer.cornerRadius = 8.0
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    
    
    // MARK: - other
    


}
