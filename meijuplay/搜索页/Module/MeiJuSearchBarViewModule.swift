//
//  MeiJuSearchBarViewModule.swift
//  meijuplay
//
//  Created by Horizon on 23/12/2021.
//

import Foundation
import SnapKit

class MeiJuSearchBarViewModule {
    // MARK: - properties
    private(set) weak var vc: MeiJuSearchVC?
    private(set) lazy var view = MeiJuSearchBarView(frame: CGRect.zero)
    private(set) var searchStr: String?
    
    // MARK: - init
    init(_ vc: MeiJuSearchVC) {
        self.vc = vc
        self.vc?.view.addSubview(view)
    
        view.cancelCallback = { [weak self] in
            self?.handleCancelAction()
        }
        
        view.textChangedCallback = { [weak self] searchStr in
            self?.handleTextChangedAction(searchStr)
        }
    }
    
    func install() {
        view.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    // MARK: - utils
    func viewBecomeFirstResponder() {
        view.viewBecomeFirstResponder()
    }
    
    func viewResignFirstResponder() {
        view.viewResignFirstResponder()
    }

    func update(_ text: String) {
        searchStr = text
        self.view.update(text)
        viewResignFirstResponder()
    }
    
    
    // MARK: - action
    fileprivate func handleCancelAction() {
        self.vc?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func handleTextChangedAction(_ searchStr: String?) {
        self.searchStr = searchStr
        guard let str = searchStr else {
            return
        }
        self.vc?.contentViewModule?.search(with: str)
    }
    
    // MARK: - other
    

}
