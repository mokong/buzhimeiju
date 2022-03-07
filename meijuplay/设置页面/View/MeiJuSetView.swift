//
//  MeiJuSetView.swift
//  meijuplay
//
//  Created by Horizon on 16/12/2021.
//

import UIKit
import SnapKit

class MeiJuSetView: UIView {
    // MARK: - properties
    var switchChangedCallback: ((MeiJuSetItem) -> Void)?
    fileprivate var tableView: UITableView?
    fileprivate var dataList: [[MeiJuSetItem]] = [[]]
    
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        if tableView == nil {
            tableView = UITableView(frame: self.bounds, style: UITableView.Style.grouped)
        }
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.showsVerticalScrollIndicator = false
        tableView?.backgroundColor = UIColor.custom.lightBackground
        tableView?.register(MeiJuSetCell.self, forCellReuseIdentifier: MeiJuSetCell.reusedId())
        tableView?.separatorStyle = .singleLine
        addSubview(tableView!)
        
        tableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    // MARK: - utils
    func update(_ list: [[MeiJuSetItem]]) {
        dataList = list
        tableView?.reloadData()
    }
    
    // MARK: - action
    
    
    // MARK: - other
    


}

extension MeiJuSetView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = dataList[section]
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = MeiJuSetHeaderView(frame: CGRect(x: 16.0, y: 0.0, width: MWScreenWidth-32.0, height: 45.0))
        var title = ""
        if section == 0 {
            title = "剧集类型"
        }
        else {
            title = "搜索页类型"
        }
        tempView.update(title)
        return tempView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: 0.1))
        tempView.backgroundColor = UIColor.custom.lightBackground
        return tempView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MeiJuSetCell.reusedId(), for: indexPath) as? MeiJuSetCell
        if cell == nil {
            cell = MeiJuSetCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: MeiJuSetCell.reusedId())
        }
        let list = dataList[indexPath.section]
        var item = list[indexPath.row]
        cell?.update(item.title, isOn: item.isEnable)
        cell?.onoffChanged = { [weak self] (isEnable) in
            item.isEnable = isEnable
            self?.switchChangedCallback?(item)
        }
        return cell!
    }
    
    
}
