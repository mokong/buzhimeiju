//
//  MeiJuSetController.swift
//  meijuplay
//
//  Created by Horizon on 16/12/2021.
//

import UIKit

/// 设置页面
class MeiJuSetController: MWBaseViewController {

    // MARK: - properties
    private(set) var module: MeiJuSetModule?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        self.title = "功能开关"
        setupSubModules()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        module?.handleNeedUpdateListView()
    }
    
    
    // MARK: - init
    fileprivate func setupSubModules() {
        if module == nil {
            module = MeiJuSetModule(self)
        }
        module?.install()
        module?.initData()
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    
    
    // MARK: - other
    



}
