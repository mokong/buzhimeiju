//
//  MeiJuAboutView.swift
//  meijuplay
//
//  Created by Horizon on 24/12/2021.
//

import UIKit
import SnapKit

class MeiJuAboutView: UIView {
    // MARK: - properties
    var selectItemCallback: ((MeiJuAboutItem) -> Void)?
    
    fileprivate let kHeaderH: CGFloat = 120.0
    fileprivate let kRowH: CGFloat = 48.0
    fileprivate let kSectionH: CGFloat = 0.1
    
    fileprivate var tableView: UITableView?
    fileprivate var tableHeaderView: MeiJuAboutHeaderView?
    fileprivate var dataList: [[MeiJuAboutItem]] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupTableView()
        setupTableHeaderView()
    }
    
    fileprivate func setupTableView() {
        if tableView == nil {
            tableView = UITableView(frame: self.bounds, style: .grouped)
        }
        tableView?.backgroundColor = UIColor.MWCustomColor.lightBackground
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.showsVerticalScrollIndicator = false
        tableView?.separatorStyle = .none
        tableView?.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: 0.1))
        tableView?.register(MeiJuAboutCell.self, forCellReuseIdentifier: MeiJuAboutCell.reuseId())
        addSubview(tableView!)
        
        tableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    fileprivate func setupTableHeaderView() {
        if tableHeaderView == nil {
            tableHeaderView = MeiJuAboutHeaderView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: kHeaderH))
        }
        tableView?.tableHeaderView = tableHeaderView
    }
    
    // MARK: - utils
    func update(with list: [[MeiJuAboutItem]]) {
        self.dataList = list
        self.tableView?.reloadData()
    }
    
    // MARK: - action
    
    
    // MARK: - other
    

}

extension MeiJuAboutView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowList = dataList[section]
        return rowList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kRowH
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: 20.0))
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0.0, y: 0.0, width: MWScreenWidth, height: 0.1))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MeiJuAboutCell.reuseId(), for: indexPath) as? MeiJuAboutCell
        if cell == nil {
            cell = MeiJuAboutCell(style: .default, reuseIdentifier: "AbountReuseID")
        }
        
        let itemList = dataList[indexPath.section]
        let item = itemList[indexPath.row]
        cell?.update(with: item.title)
        
        if indexPath.row == 0 {
            cell?.updateShowTopLine(true)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemList = dataList[indexPath.section]
        let item = itemList[indexPath.row]
        selectItemCallback?(item)
    }
}
