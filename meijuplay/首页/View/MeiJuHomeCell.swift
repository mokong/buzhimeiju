//
//  MeiJuHomeCell.swift
//  meijuplay
//
//  Created by Horizon on 7/12/2021.
//

import UIKit
import UIKit
import Kingfisher

/// 首页 cell
class MeiJuHomeCell: UICollectionViewCell {
    
    // MARK: - properties
    fileprivate lazy var imageView: UIImageView = UIImageView()
    fileprivate lazy var displayLabel: UILabel = UILabel()
//    fileprivate lazy var countBtn: UIButton
    
    // MARK: - init
    func setupSubviews() {
        setupImageView()
        setupDisplayLabel()
    }
    
    fileprivate func setupImageView() {
        imageView.backgroundColor = UIColor.MWCustomColor.lightBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    fileprivate func setupDisplayLabel() {
        displayLabel.numberOfLines = 1
        displayLabel.textAlignment = .center
        displayLabel.font = UIFont.custom.normalFont
        displayLabel.minimumScaleFactor = 0.5
        displayLabel.adjustsFontSizeToFitWidth = true
        displayLabel.textColor = UIColor.custom.primaryText
        contentView .addSubview(displayLabel)
        
        displayLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(18.0)
            make.top.equalTo(imageView.snp.bottom).inset(-4.0)
        }
    }
    
    // MARK: - utils
    func updateSubviews(with text: String?, imageUrl: String?) {
        if let tempStr = imageUrl {
            let url = URL(string: tempStr)
            imageView.kf.setImage(with: url)
        }
        
        displayLabel.text = text
    }
    
    // MARK: - action
    
    
    // MARK: - other
    class func reuseId() -> String {
        return "MeiJuHomeCell"
    }

}
