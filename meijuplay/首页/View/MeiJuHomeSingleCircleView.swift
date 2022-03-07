//
//  MeiJuHomeSingleCircleView.swift
//  meijuplay
//
//  Created by Horizon on 8/12/2021.
//

import UIKit
import SnapKit
import SwifterSwift
import Kingfisher

/// 轮播图
class MeiJuHomeSingleCircleView: UIView {

    // MARK: - properties
    var tapCallback: (() -> Void)?
    
    fileprivate lazy var imageView: UIImageView = UIImageView()
    fileprivate lazy var bottomAlphaView: UIView = UIView()
    fileprivate lazy var label: UILabel = UILabel()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupSubviewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        addSubview(imageView)
        
        bottomAlphaView.backgroundColor = Color.init(hexString: "#000000", transparency: 0.4)
        addSubview(bottomAlphaView)
        
        label.font = UIFont.custom.normalFont
        label.textColor = UIColor.custom.whiteText
        addSubview(label)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(tapGes)
    }
    
    fileprivate func setupSubviewsLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomAlphaView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(44.0)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.centerY.equalTo(bottomAlphaView.snp.centerY)
        }
    }
    
    // MARK: - utils
    func update(with imageStr: String?, text: String?) {
        if let tempStr = imageStr {
            let url = URL(string: tempStr)
            imageView.kf.setImage(with: url)
        }
        label.text = text
    }
    
    // MARK: - action
    @objc fileprivate func tapAction(_ sender: UITapGestureRecognizer) {
        tapCallback?()
    }
    
    // MARK: - other
    


}
