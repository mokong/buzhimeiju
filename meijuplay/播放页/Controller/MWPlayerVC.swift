//
//  MWPlayerVC.swift
//  meijuplay
//
//  Created by Horizon on 16/12/2021.
//

import UIKit

/// 播放器
class MWPlayerVC: MWBaseViewController {

    // MARK: properties
    var inputStr: String?
    var playerViewModule: MWPlayerViewModule?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "播放"
        setupPlayerViewModule()
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - init
    func setupPlayerViewModule() {
        if playerViewModule == nil {
            playerViewModule = MWPlayerViewModule(self)
        }
        playerViewModule?.install()
        playerViewModule?.initData(with: inputStr)
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    
    
    // MARK: - other
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if MWInterfaceIdiom == .pad {
            return .landscape
        }
        else {
            return .portrait
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if MWInterfaceIdiom == .pad {
            return .landscapeRight
        }
        else {
            return .portrait
        }
    }


}
