//
//  MeiJuAboutCell.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import UIKit

class MeiJuAboutCell: UITableViewCell {

    // MARK: - properties
    fileprivate var leftLabel: UILabel?
    fileprivate var rightImageView: UIImageView?
    fileprivate var topLine: UIView?
    fileprivate var bottomLine: UIView?
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        contentView.backgroundColor = UIColor.MWCustomColor.background
        setupTopLine()
        setupLeftLabel()
        setupRightImageView()
        setupBottomLine()
    }
    
    fileprivate func setupTopLine() {
        if topLine == nil {
            topLine = UIView()
        }
        topLine?.backgroundColor = UIColor.MWCustomColor.line
        topLine?.isHidden = true
        contentView.addSubview(topLine!)
        
        topLine?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(0.6)
        })
    }
    
    fileprivate func setupBottomLine() {
        if bottomLine == nil {
            bottomLine = UIView()
        }
        bottomLine?.backgroundColor = UIColor.MWCustomColor.line
        contentView.addSubview(bottomLine!)
        
        bottomLine?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.6)
        })
    }
    
    fileprivate func setupLeftLabel() {
        if leftLabel == nil {
            leftLabel = UILabel()
        }
        contentView.addSubview(leftLabel!)
        
        leftLabel?.font = UIFont.MWCustomFont.normalFont
        leftLabel?.textAlignment = .left
        leftLabel?.textColor = UIColor.MWCustomColor.primaryText
        
        leftLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        })
    }
    
    fileprivate func setupRightImageView() {
        if rightImageView == nil {
            rightImageView = UIImageView()
        }
        rightImageView?.image = UIImage(named: "dark_arrow_right")
        contentView.addSubview(rightImageView!)
        
        rightImageView?.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        })
    }

    // MARK: - utils
    func update(with title: String?) {
        leftLabel?.text = title
    }
    
    func updateShowTopLine(_ show: Bool) {
        topLine?.isHidden = !show
    }
    
    // MARK: - action
    
    
    // MARK: - other
    class func reuseId() -> String {
        return "MeiJuAboutCell"
    }

}
