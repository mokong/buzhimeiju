//
//  MeiJuSetHeaderView.swift
//  meijuplay
//
//  Created by Horizon on 9/1/2022.
//

import UIKit
import SnapKit

class MeiJuSetHeaderView: UIView {

    // MARK: - properties
    fileprivate var titleLabel: UILabel?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        if titleLabel == nil {
            titleLabel = UILabel()
        }
        titleLabel?.font = UIFont.MWCustomFont.headerFont
        titleLabel?.textColor = UIColor.custom.primaryText
        addSubview(titleLabel!)
        
        titleLabel?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        })
    }
    
    // MARK: - utils
    func update(_ title: String?) {
        titleLabel?.text = title
    }
    
    // MARK: - action
    
    
    // MARK: - other
    

}
