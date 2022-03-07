//
//  MeiJuListVC.swift
//  meijuplay
//
//  Created by Horizon on 20/12/2021.
//

import UIKit
import CryptoKit

class MeiJuListVC: MWBaseViewController {

    // MARK: - properties
    private(set) var isLeftShow: Bool = false
    
    private(set) var leftModule: MeiJuLeftFuncModule?
    private(set) var listModule: MeiJuListModule?
    private(set) var privacyModule: PrivacyAlertViewModule?
    
    fileprivate var needReload = false
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        
        if haveAgreePolicy() {
            setupSubModules()
        }
        else {
            setupPrivacyAlert()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(typeRefreshAction(_:)), name: Notification.Name(rawValue: KTypeChangedNote), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchChangedAction(_:)), name: NSNotification.Name(rawValue: KSwitchChangedNote), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        if needReload {
            updateListView()
            needReload = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - init
    
    fileprivate func setupPrivacyAlert() {
        if privacyModule == nil {
            privacyModule = PrivacyAlertViewModule(self)
        }
        privacyModule?.show(title: "隐私政策",
                            desc: "在使用不止美剧前，请务必仔细阅读并同意《用户服务协议和隐私政策》。您可以选择不使用不止美剧，但如果您使用不止美剧，您的使用行为即表示您知悉、理解并同意接受本协议的全部内容",
                            highlightStr: "《用户服务协议和隐私政策》",
                            leftBtnStr: "不同意",
                            rightBtnStr: "知晓并同意")
        privacyModule?.actionCallback = { [weak self] index in
            self?.handleBtnTapped(index)
        }
    }
    
    fileprivate func setupSubModules() {
        setupLeftFuncModule()
        setupListModule()
    }
    
    fileprivate func setupLeftFuncModule() {
        if leftModule == nil {
            leftModule = MeiJuLeftFuncModule(self)
        }
        leftModule?.install()
        leftModule?.initData()
    }
    
    fileprivate func setupListModule() {
        if listModule == nil {
            listModule = MeiJuListModule(self)
        }
        listModule?.install()
        listModule?.initData(with: true)
    }
    
    
    // MARK: - utils
    
    // MARK: - Action
    func menuBarItemAction(_ animatedDuration: CGFloat = 0.3) {
        isLeftShow = !isLeftShow
        if isLeftShow {
            leftModule?.show()
        }
        else {
            leftModule?.hide()
        }
        
        UIView.animate(withDuration: animatedDuration, delay: 0, options: UIView.AnimationOptions.curveEaseInOut) {
            self.view.layoutIfNeeded()
        } completion: { finished in
            if finished {
                self.leftModule?.reloadData()
            }
        }
    }
    
    func searchBarItemAction() {
        let searchVC = MeiJuSearchVC()
        let searchNC = MWNavigationController(rootViewController: searchVC)
        searchNC.modalPresentationStyle = .overFullScreen
        searchNC.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.present(searchNC, animated: true, completion: nil)
    }

    @objc fileprivate func typeRefreshAction(_ sender: Notification) {
        if self.view.window == nil { // 界面不可见时，等见面出现再刷新
            self.needReload = true
            return
        }
        
        updateListView()
    }
    
    @objc fileprivate func switchChangedAction(_ sender: Notification) {
        leftModule?.initData()
    }
    
    fileprivate func handleBtnTapped(_ index: Int) {
        if index == 1 {
            // 确认
            UserDefaults.standard.setValue("1", forKey: kIsAgreePrivacy)
            UserDefaults.standard.synchronize()
            setupSubModules()
        }
        else {
            // 取消
            exit(0)
        }
    }
    
    // MARK: - other
    fileprivate func updateListView() {
        self.title = ProjectConsts.shared.navTitle()
        listModule?.scrollToTop()
        listModule?.initData(with: true)
    }

    fileprivate func haveAgreePolicy() -> Bool {
        let value = UserDefaults.standard.value(forKey: kIsAgreePrivacy) as? String
        if value == nil || value == "0" {
            // 说明没有同意
            return false
        }
        else {
            return true
        }
    }

}
