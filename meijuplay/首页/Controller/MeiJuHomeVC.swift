//
//  MeiJuHomeVC.swift
//  meijuplay
//
//  Created by MorganWang on 2021/11/28.
//

import UIKit

/// 首页
class MeiJuHomeVC: MWBaseViewController {

    // MARK: - properties
    fileprivate var homeModule: MeiJuHomeModule?


    // MARK: - init
    fileprivate func setupSubModules() {
        if homeModule == nil {
            homeModule = MeiJuHomeModule(self)
        }
        homeModule?.install()
        homeModule?.initData()
    }
    
    fileprivate func setupLeftNavBarItems() {
        let navBarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(menuBarItemAction(_:)));
        self.navigationItem.leftBarButtonItem = navBarItem
    }
    
    fileprivate func setupRightNavBarItems() {
        let navBarItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchBarItemAction(_:)))
        self.navigationItem.rightBarButtonItem = navBarItem
    }
    
    // MARK: - Action
    @objc fileprivate func menuBarItemAction(_ sender: UIBarButtonItem) {
        
    }
    
    @objc fileprivate func searchBarItemAction(_ sender: UIBarButtonItem) {
        
    }

    // MARK: - Util



    // MARK: - Other

    


    // MARK: - view life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = "首页"
        
        setupLeftNavBarItems()
        setupRightNavBarItems()
        setupSubModules()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
}
