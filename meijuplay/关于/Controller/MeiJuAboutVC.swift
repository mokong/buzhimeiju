//
//  MeiJuAboutVC.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import UIKit

class MeiJuAboutVC: MWBaseViewController {
    
    // MARK: - properties
    fileprivate var aboutModule: MeiJuAboutViewModule?
    
    // MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "不止美剧"
        self.navigationController?.navigationBar.isHidden = false
        setupSubModules()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    // MARK: - init
    fileprivate func setupSubModules() {
        if aboutModule == nil {
            aboutModule = MeiJuAboutViewModule(self)
        }
        aboutModule?.install()
        aboutModule?.initData()
    }
    
    // MARK: - utils
    
    
    // MARK: - action
    
    
    // MARK: - other
    


}
