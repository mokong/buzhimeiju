//
//  MeiJuLeftFunModule.swift
//  meijuplay
//
//  Created by Horizon on 21/12/2021.
//

import Foundation
import SnapKit

class MeiJuLeftFuncModule {
    // MARK: - properties
    
    private(set) weak var vc: MeiJuListVC?
    private(set) lazy var view = MeiJuLeftFuncView(frame: CGRect(x: -kLeftFuncViewW - 1.0, y: 0.0, width: kLeftFuncViewW, height: MWScreenHeight))
    fileprivate var dataList: [[MeiJuFuncItem]] = [[]]
    
    
    // MARK: - init
    init(_ vc: MeiJuListVC) {
        self.vc = vc
        
        setupSubviews()
    }
    
    fileprivate func setupSubviews() {
        self.vc?.view.addSubview(view)
        
        view.selectItemAction = { [weak self] item in
            self?.handleSelectItem(item)
        }
    }
    
    func install() {
        hide()
    }
    
    func initData() {
        
        var group1: [MeiJuFuncItem] = []
        
        let typeList: [EpisodeType] = [.MeiJu, .HanJu, .RiJu, .TaiJu]
        for type in typeList {
            let item = customFuncItem(from: type)
            let enableValue = MeiJuSetItem.savedEnableValue(type)
            if enableValue == "1" {
                group1.append(item)
            }
        }
    
        let item5 = MeiJuFuncItem(title: "功能开关", selectType: FuncItemSelectType.jump, tagStr: FuncItemJumpType.set.rawValue)
        let item6 = MeiJuFuncItem(title: "关于我们", selectType: FuncItemSelectType.jump, tagStr: FuncItemJumpType.about.rawValue)
        let group2 = [item5, item6]
        
        let resultList = [group1, group2]
        self.dataList = resultList
        self.reloadData()
    }
    
    func customFuncItem(from type: EpisodeType) -> MeiJuFuncItem {
        let title = MeiJuSetItem.titleFromType(type)
        let customItem = MeiJuFuncItem(title: title, selectType: .select, tagStr: type.rawValue)
        return customItem
    }
    
    func reloadData() {
        self.view.update(with: self.dataList)
    }
    
    // MARK: - utils
    func show() {        
        view.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kLeftFuncViewW)
            make.leading.equalToSuperview()
        }
    }
    
    func hide() {
        view.snp.remakeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kLeftFuncViewW)
            make.leading.equalToSuperview().inset(-kLeftFuncViewW)
        }
    }
    
    // MARK: - action
    fileprivate func handleSelectItem(_ item: MeiJuFuncItem) {
        if item.selectType == .select {
            ProjectConsts.shared.update(type: EpisodeType(rawValue: item.tagStr!)!)
            vc?.menuBarItemAction()
        }
        else if item.selectType == .jump {
            vc?.menuBarItemAction(0.0)

            if item.tagStr == FuncItemJumpType.set.rawValue {
                // 设置                
                let setVC = MeiJuSetController()
                self.vc?.navigationController?.pushViewController(setVC, animated: true)
            }
            else {
                // 关于
                let aboutVC = MeiJuAboutVC()
                self.vc?.navigationController?.pushViewController(aboutVC, animated: true)
            }
        }
    }
    
    // MARK: - other
    

}
