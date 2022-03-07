//
//  MWDevOtherAppsCell.swift
//  meijuplay
//
//  Created by Horizon on 25/2/2022.
//

import UIKit

class MWDevOtherAppsCell: UITableViewCell {

    // MARK: - properties
    fileprivate lazy var displayImageView: UIImageView = UIImageView()
    fileprivate lazy var displayLabel: UILabel = UILabel()
    fileprivate lazy var rightImageView: UIImageView = UIImageView()
    
    // MARK: - init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
        setupLayouts()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        displayImageView.layer.cornerRadius = 5.0
        displayImageView.clipsToBounds = true
        contentView.addSubview(displayImageView)
        
        displayLabel.font = UIFont.MWCustomFont.normalFont
        displayLabel.textColor = UIColor.MWCustomColor.primaryText
        contentView.addSubview(displayLabel)
        
        rightImageView.image = UIImage(named: "dark_arrow_right")
        contentView.addSubview(rightImageView)
    }
    
    fileprivate func setupLayouts() {
        displayImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(21.0)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(20.0)
            make.width.height.equalTo(48.0)
        }
        
        displayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(displayImageView.snp.trailing).inset(-10.0)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(21.0)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - utils
    func update(_ imageName: String, text: String) {
        displayImageView.image = UIImage(named: imageName)
        displayLabel.text = text
    }
    
    // MARK: - action
    
    
    // MARK: - other
    class func reuseIdentifer() -> String {
        return "MWDevOtherAppsCell"
    }


}
