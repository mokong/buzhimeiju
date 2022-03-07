//
//  PrivacyAlertViewModule.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import Foundation
import UIKit
import SnapKit

class PrivacyAlertViewModule {
    // MARK: - properties
    fileprivate let kAlertViewH: CGFloat = 300.0
    fileprivate weak var vc: UIViewController?
    fileprivate lazy var alphaView = UIView(frame: UIScreen.main.bounds)
    fileprivate lazy var view = PrivacyAlertView(frame: .zero)
    
    var actionCallback: ((Int) -> Void)?
    
    // MARK: - init
    init(_ vc: UIViewController) {
        self.vc = vc
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        alphaView.alpha = 0.2
        alphaView.backgroundColor = UIColor.black
        self.vc?.view.addSubview(alphaView)
        
        self.vc?.view.addSubview(view)
        
        view.btnTapped = { [weak self] index in
            self?.actionCallback?(index)
        }
        
        view.contentTapped = { [weak self] in
            let privacyVC = MeiJuPrivacyVC()
            self?.vc?.navigationController?.pushViewController(privacyVC, animated: true)
        }
    }
    
    func install() {
        view.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().inset(30.0)
        }
    }
    
    // MARK: - utils
    func show(title: String, desc: String, highlightStr: String?, leftBtnStr: String, rightBtnStr: String) {
        view.update(title: title, desc: desc, highlightStr: highlightStr, leftBtnStr: leftBtnStr, rightBtnStr: rightBtnStr)
        install()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hide() {
        view.removeFromSuperview()
        alphaView.removeFromSuperview()
    }
    
    // MARK: - action
    
    
    // MARK: - other
    

}
