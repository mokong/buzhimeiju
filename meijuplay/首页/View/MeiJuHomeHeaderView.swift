//
//  MeiJuHomeHeaderView.swift
//  meijuplay
//
//  Created by Horizon on 7/12/2021.
//

import UIKit
import SnapKit

/// 轮播图
class MeiJuHomeHeaderView: UICollectionReusableView {
    // MARK: - properties
    fileprivate lazy var displayLabel: UILabel = UILabel()
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        displayLabel.font = UIFont.custom.titleFont
        displayLabel.textColor = UIColor.custom.primaryText
        self.addSubview(displayLabel)
        
        displayLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(32.0)
            make.centerY.equalToSuperview()
        }
    }
    
    
    // MARK: - utils
    func update(with text: String?) {
        displayLabel.text = text
    }
    
    // MARK: - action
    
    
    // MARK: - other
    class func reuseId() -> String {
        return "MeiJuHomeHeaderView"
    }


}

