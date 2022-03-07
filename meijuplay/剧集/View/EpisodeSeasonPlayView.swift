//
//  EpisodeSeasonPlayView.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import UIKit
import SnapKit
import Kingfisher

class EpisodeSeasonPlayView: UIView {

    // MARK: - properties
    var playBtnCallback: (() -> Void)?
    
    fileprivate var bottomImageView: UIImageView?
    fileprivate var visualEffectView: UIVisualEffectView?
    fileprivate var displayImageView: UIImageView?
    fileprivate var topButton: UIButton?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        backgroundColor = UIColor.black
        setupBottomImageView()
        setupDisplayImageView()
        setupTopButton()
    }
    
    fileprivate func setupBottomImageView() {
        if bottomImageView == nil {
            bottomImageView = UIImageView()
        }
        addSubview(bottomImageView!)
        
        // 创建毛玻璃效果层
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light)) as UIVisualEffectView
        visualEffectView?.frame = bottomImageView!.frame
            //添加毛玻璃效果层
        bottomImageView?.addSubview(visualEffectView!)
        
        bottomImageView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    fileprivate func setupDisplayImageView() {
        if displayImageView == nil {
            displayImageView = UIImageView()
        }
        addSubview(displayImageView!)
        displayImageView?.contentMode = .scaleAspectFill
        
        displayImageView?.snp.makeConstraints({ make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(150.0)
        })
    }

    
    fileprivate func setupTopButton() {
        if topButton == nil {
            topButton = UIButton(type: .custom)
        }
        addSubview(topButton!)
        let tempImage = UIImage(named: "episode_play")
        topButton?.setImage(tempImage, for: .normal)
        topButton?.addTarget(self, action: #selector(playBtnTapped(_:)), for: .touchUpInside)
        
        topButton?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        visualEffectView?.frame = bottomImageView!.bounds
    }
    
    // MARK: - utils
    func update(with imgUrl: String?) {
        topButton?.isHidden = ProjectConsts.shared.isInReview

        if let urlStr = imgUrl {
            let url = URL(string: urlStr)
            bottomImageView?.kf.setImage(with: url)
            displayImageView?.kf.setImage(with: url)
        }
    }
   
    // MARK: - action
    @objc fileprivate func playBtnTapped(_ sender: UIButton) {
        playBtnCallback?()
    }
    
    // MARK: - other
    


}
