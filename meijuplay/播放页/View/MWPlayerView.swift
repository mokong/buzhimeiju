//
//  MWPlayerView.swift
//  meijuplay
//
//  Created by Horizon on 31/12/2021.
//

import UIKit
import SnapKit
import Toast_Swift

class MWPlayerView: UIView {

    // MARK: - properties
    var handlePlayAction: ((String) -> Void)?
    
    private(set) var playBackView: UIView?
    fileprivate var inputTextField: UITextField?
    fileprivate var playButton: UIButton?
    fileprivate let kInputTFH: CGFloat = 54.0
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupPlayBackView()
        setupInputTextField()
        setupPlayButton()
    }
    
    fileprivate func setupPlayBackView() {
        if playBackView == nil {
            playBackView = UIView()
        }
        addSubview(playBackView!)
        
        playBackView?.backgroundColor = UIColor.black
        
        playBackView?.snp.makeConstraints({ make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(kPlayerViewH)
        })
    }
    
    fileprivate func setupInputTextField() {
        if inputTextField == nil {
            inputTextField = UITextField()
        }
        inputTextField?.font = UIFont.MWCustomFont.normalFont
        inputTextField?.textColor = UIColor.MWCustomColor.primaryText
        inputTextField?.placeholder = "请输入要播放的链接"
        inputTextField?.borderStyle = .roundedRect
        addSubview(inputTextField!)
        
        inputTextField?.snp.makeConstraints({ make in
            make.leading.trailing.equalToSuperview().inset(20.0)
            make.top.equalTo(playBackView!.snp.bottom).inset(-20.0)
            make.height.equalTo(kInputTFH)
        })
    }
    
    fileprivate func setupPlayButton() {
        if playButton == nil {
            playButton = UIButton(type: .custom)
        }
        playButton?.titleLabel?.font = UIFont.MWCustomFont.titleFont
        playButton?.setTitle("播放", for: .normal)
        playButton?.setTitleColor(UIColor.white, for: .normal)
        playButton?.addTarget(self, action: #selector(playTapped(_:)), for: .touchUpInside)
        
        let type = ProjectConsts.shared.selectType
        playButton?.backgroundColor = UIViewController.navBarColor(type)
        playButton?.cornerRadius = 4.0
        
        addSubview(playButton!)
        
        playButton?.snp.makeConstraints({ make in
            make.top.equalTo(inputTextField!.snp.bottom).inset(-40.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(120.0)
            make.height.equalTo(50.0)
        })
    }
    
    // MARK: - utils
    func update(with inputStr: String) {
        self.inputTextField?.text = inputStr
    }
    
    // MARK: - action
    @objc fileprivate func playTapped(_ sender: UIButton) {
        guard let str = inputTextField?.text,
                str.count > 0,
        str.hasPrefix("http") else {
            self.makeToast("播放链接不合法", duration: 2.0, position: ToastPosition.center, completion: nil)
            return
        }
        handlePlayAction?(str)
    }
    
    // MARK: - other
    


}
