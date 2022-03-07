//
//  MeiJuSearchVC.swift
//  meijuplay
//
//  Created by MorganWang on 2021/11/28.
//

import UIKit

/// 搜索页
class MeiJuSearchVC: MWBaseViewController {

    // MARK: - properties
    private(set) var searchBarModule: MeiJuSearchBarViewModule?
    private(set) var suggestViewModule: MeiJuSearchSuggestViewModule?
    private(set) var contentViewModule: MeiJuSearchContentViewModule?
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        modalPresentationCapturesStatusBarAppearance = true
        navigationController?.navigationBar.isHidden = true
        setupSubModules()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let text = searchBarModule?.searchStr, text.count > 0 {
            
        }
        else {
            searchBarModule?.viewBecomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBarModule?.viewResignFirstResponder()
    }
    
    // MARK: - init
    fileprivate func setupSubModules() {
        setupSearchBarModule()
        setupSuggestViewModule()
        setupContentViewModule()
    }
    
    fileprivate func setupSearchBarModule() {
        if searchBarModule == nil {
            searchBarModule = MeiJuSearchBarViewModule(self)
        }
        searchBarModule?.install()
    }
    
    fileprivate func setupSuggestViewModule() {
        if suggestViewModule == nil {
            suggestViewModule = MeiJuSearchSuggestViewModule(self)
        }
        suggestViewModule?.initData()
        suggestViewModule?.install()
    }
    
    fileprivate func setupContentViewModule() {
        if contentViewModule == nil {
            contentViewModule = MeiJuSearchContentViewModule(self)
        }
        contentViewModule?.install()
    }
    
    // MARK: - utils
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - action
    
    
    // MARK: - other
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
        }
    }

}
