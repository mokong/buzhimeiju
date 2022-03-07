//
//  MeiJuSetCell.swift
//  meijuplay
//
//  Created by Horizon on 17/12/2021.
//

import UIKit
import SnapKit

class MeiJuSetCell: UITableViewCell {

    // MARK: - properties
    var onoffChanged: ((Bool) -> Void)?
    
    fileprivate var displayLabel: UILabel?
    fileprivate var rightSwitch: UISwitch?
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.custom.background
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    fileprivate func setupSubviews() {
        setupDisplayLabel()
        setupRightSwitch()
    }
    
    fileprivate func setupDisplayLabel() {
        if displayLabel == nil {
            displayLabel = UILabel()
        }
        contentView.addSubview(displayLabel!)
        
        displayLabel?.font = UIFont.custom.normalFont
        displayLabel?.textColor = UIColor.custom.primaryText
        
        displayLabel?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        })
    }
    
    fileprivate func setupRightSwitch() {
        if rightSwitch == nil {
            rightSwitch = UISwitch()
        }
        contentView.addSubview(rightSwitch!)
        rightSwitch?.isOn = true
        rightSwitch?.addTarget(self, action: #selector(switchValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        rightSwitch?.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(16.0)
            make.centerY.equalToSuperview()
        })
    }
    
    // MARK: - utils
    func update(_ title: String?, isOn: Bool) {
        displayLabel?.text = title
        rightSwitch?.isOn = isOn
    }
    
    // MARK: - action
    @objc fileprivate func switchValueChanged(_ sender: UISwitch) {
        onoffChanged?(sender.isOn)
    }
    
    // MARK: - other
    class func reusedId() -> String {
        return "MeiJuSetCell"
    }


}
