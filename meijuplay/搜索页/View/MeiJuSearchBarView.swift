//
//  MeiJuSearchBarView.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import UIKit
import SnapKit

/// 搜索
class MeiJuSearchBarView: UIView {

    // MARK: - properties
    var textChangedCallback: ((String?) -> Void)?
    var cancelCallback: (() -> Void)?
    
    fileprivate let kCancelButtonW: CGFloat = 64.0
    fileprivate let kSearchbarH: CGFloat = 44.0
    fileprivate var backView: UIView?
    fileprivate var searchImageView: UIImageView?
    fileprivate var textField: UITextField?
    fileprivate var cancelButton: UIButton?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
//        let type = ProjectConsts.shared.selectType
//        backgroundColor = UIViewController.navBarColor(type)
        backgroundColor = UIColor.MWCustomColor.background
        setupBackView()
        setupSearchImageView()
        setupTextField()
        setupCancelButton()
    }
    
    fileprivate func setupBackView() {
        if backView == nil {
            backView = UIView()
        }
        addSubview(backView!)
        
        backView?.backgroundColor = UIColor.MWCustomColor.line
        backView?.layer.cornerRadius = kSearchbarH / 2.0
        backView?.layer.borderColor = UIColor.MWCustomColor.line.cgColor
        backView?.layer.borderWidth = 0.6
        
        let statusBarH = UIDevice.statusBarH()
        backView?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(statusBarH)
            make.height.equalTo(kSearchbarH)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(kCancelButtonW)
        })
    }
    
    fileprivate func setupSearchImageView() {
        if searchImageView == nil {
            searchImageView = UIImageView()
        }
        searchImageView?.image = UIImage(named: "searchbar")
        backView?.addSubview(searchImageView!)
        
        searchImageView?.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(14.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(27.0)
        })
    }
    
    fileprivate func setupTextField() {
        if textField == nil {
            textField = UITextField()
        }
        textField?.delegate = self
        textField?.clearButtonMode = .whileEditing
        textField?.placeholder = "搜搜你感兴趣的"
        textField?.textColor = UIColor.MWCustomColor.primaryText
        textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        textField?.returnKeyType = .search
        backView?.addSubview(textField!)
        
        textField?.snp.makeConstraints({ make in
            make.leading.equalTo(searchImageView!.snp.trailing).inset(-4.0)
            make.trailing.equalToSuperview().inset(14.0)
            make.top.bottom.equalToSuperview()
        })
    }
    
    fileprivate func setupCancelButton() {
        if cancelButton == nil {
            cancelButton = UIButton(type: .custom)
        }
        cancelButton?.titleLabel?.font = UIFont.MWCustomFont.headerFont
        cancelButton?.setTitleColor(UIColor.MWCustomColor.primaryText, for: .normal)
        cancelButton?.setTitle("返回", for: .normal)
        cancelButton?.addTarget(self, action: #selector(cancelTapped(_:)), for: .touchUpInside)
        addSubview(cancelButton!)
        
        cancelButton?.snp.makeConstraints({ make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(kSearchbarH)
            make.width.equalTo(kCancelButtonW)
        })
    }
    
    // MARK: - utils
    func viewBecomeFirstResponder() {
        textField?.becomeFirstResponder()
    }
    
    func viewResignFirstResponder() {
        textField?.resignFirstResponder()
    }
    
    // MARK: - action
    @objc fileprivate func cancelTapped(_ sender: UIButton) {
        cancelCallback?()
    }
    
    func update(_ text: String?) {
        self.textField?.text = text
        textChangedCallback?(text)
    }
    
    // MARK: - other
    

}

extension MeiJuSearchBarView: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textFiled: UITextField) {
        textChangedCallback?(textFiled.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
