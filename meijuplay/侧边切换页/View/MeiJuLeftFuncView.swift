//
//  MeiJuLeftFuncView.swift
//  meijuplay
//
//  Created by Horizon on 21/12/2021.
//

import UIKit
import SnapKit

class MeiJuLeftFuncView: UIView {

    // MARK: - properties
    var selectItemAction: ((MeiJuFuncItem) -> Void)?
    
    fileprivate let kSectionHeaderH: CGFloat = 40.0
    fileprivate let kRowH: CGFloat = MWScreenWidth > 700.0 ? 81.0 : 54.0
    
    fileprivate var tableView: UITableView?
    fileprivate var dataList: [[MeiJuFuncItem]] = [[]]
    
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
            tableView = UITableView(frame: self.bounds, style: UITableView.Style.grouped)
        }
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.backgroundColor = UIColor.MWCustomColor.dimBack
        tableView?.showsHorizontalScrollIndicator = false
        tableView?.register(MeiJuLeftFuncCell.self, forCellReuseIdentifier: MeiJuLeftFuncCell.reuseId())
        addSubview(tableView!)
        
        tableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    fileprivate func setupTableHeaderView() {
        let headerH = UIDevice.navigationBarH()
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: headerH))
        headerView.backgroundColor = UIColor.MWCustomColor.dimBack
        tableView?.tableHeaderView = headerView
    }
    
    // MARK: - utils
    func update(with list: [[MeiJuFuncItem]]) {
        self.dataList = list
        tableView?.reloadData()
    }
    
    // MARK: - action
    
    
    // MARK: - other
    


}

extension MeiJuLeftFuncView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = dataList[section]
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kSectionHeaderH
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kRowH
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: kSectionHeaderH))
        headerView.backgroundColor = UIColor.MWCustomColor.dimBack
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MeiJuLeftFuncCell.reuseId(), for: indexPath) as? MeiJuLeftFuncCell
        if cell == nil {
            cell = MeiJuLeftFuncCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: MeiJuLeftFuncCell.reuseId())
        }
        let rowNum = indexPath.row
        let list = dataList[indexPath.section]
        let item = list[rowNum]
        
        cell?.update(with: item)
        cell?.updateShowTopLine(rowNum == 0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let rowNum = indexPath.row
        let list = dataList[indexPath.section]
        let item = list[rowNum]

        selectItemAction?(item)
    }
}
