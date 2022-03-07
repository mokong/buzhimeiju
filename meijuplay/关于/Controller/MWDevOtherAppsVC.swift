//
//  MWDevOtherAppsVC.swift
//  meijuplay
//
//  Created by Horizon on 25/2/2022.
//

import UIKit

class MWDevOtherAppsVC: MWBaseViewController {

    // MARK: - properties
    private(set) lazy var module: MWDevOtherAppsModule = MWDevOtherAppsModule(self)
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "我其他的APP"
        setupSubModules()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    deinit {
        let classStr = NSStringFromClass(self.classForCoder)
        print(classStr, "deinit")
    }

    
    // MARK: - init
    fileprivate func setupSubModules() {
        module.install()
        module.initData()
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    
    
    // MARK: - other
    


}
