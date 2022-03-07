//
//  MeiJuAboutViewModule.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import Foundation
import UIKit

class MeiJuAboutViewModule {
    // MARK: - properties
    fileprivate weak var vc: MeiJuAboutVC?
    fileprivate lazy var view = MeiJuAboutView(frame: .zero)
    
    // MARK: - init
    init(_ vc: MeiJuAboutVC) {
        self.vc = vc
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.selectItemCallback = { [weak self] item in
            self?.handleSelectItem(item)
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func initData() {
        let privacyItem = MeiJuAboutItem()
        privacyItem.title = "隐私声明"
        privacyItem.type = .policy

        let commentItem = MeiJuAboutItem()
        commentItem.title = "去评价"
        commentItem.type = .comment

        let shareItem = MeiJuAboutItem()
        shareItem.title = "分享App"
        shareItem.type = .share
        
        let otherApps = MeiJuAboutItem()
        otherApps.title = "开发者的其他 App"
        otherApps.type = .devOtherApps
        
        view.update(with: [[privacyItem], [commentItem, shareItem], [otherApps]])
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    fileprivate func handleSelectItem(_ item: MeiJuAboutItem) {
        print(item.title)
        
        switch item.type {
        case .policy:
            self.handlePolicyAction()
        case .share:
            self.handleShareApp()
        case .devOtherApps:
            self.handleDevOtherApps()
        case .comment:
            self.handleComment()
        }
    }
    
    fileprivate func handlePolicyAction() {
        let policyVC = MeiJuPrivacyVC()
        self.vc?.navigationController?.pushViewController(policyVC, animated: true)
    }
    
    fileprivate func handleShareApp() {
        self.view.makeToastActivity(self.view.center)
        
        let url = URL(string: kAppStoreUrl)
        let array: [Any] = ["不止美剧", url as Any]
        let activityVC = UIActivityViewController(activityItems: array, applicationActivities: nil)
        
        self.view.hideToastActivity()
        
        //需要做一个 iPhone 和 iPad的判断
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            activityVC.popoverPresentationController?.sourceView = self.vc!.view
            UIPasteboard.general.string = kAppStoreUrl
            self.view.makeToast("已复制下载链接")
        }
        
        self.vc!.present(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = { (type, completed, items, error) in
            if completed {
                print("分享成功")
            }
            else {
                print("分享失败")
            }
        }
    }
    
    fileprivate func handleDevOtherApps() {
        let otherAppsVC = MWDevOtherAppsVC()
        self.vc?.navigationController?.pushViewController(otherAppsVC, completion: nil)
    }
    
    fileprivate func handleComment() {
        let urlString = kAppStoreCommentUrl
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:],completionHandler: {(success) in})
        }
    }
    
    @objc fileprivate func handleCancel(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - other
    

}
