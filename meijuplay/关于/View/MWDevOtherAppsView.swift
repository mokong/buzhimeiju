//
//  MWDevOtherAppsView.swift
//  meijuplay
//
//  Created by Horizon on 25/2/2022.
//

import UIKit

class MWDevOtherAppsView: UIView {

    // MARK: - properties
    var selectItemCallback: ((MWDevAppType) -> Void)?
    fileprivate lazy var tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
    fileprivate var dataList: [MWDevAppType] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupSubviews() {
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.MWCustomColor.lightBackground
        tableView.register(MWDevOtherAppsCell.self, forCellReuseIdentifier: MWDevOtherAppsCell.reuseIdentifer())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76.0
        addSubview(tableView)
    }
    
    fileprivate func setupLayouts() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - utils
    func update(_ list: [MWDevAppType]) {
        self.dataList = list
        self.tableView.reloadData()
    }
    
    // MARK: - action
    
    
    // MARK: - other

}

extension MWDevOtherAppsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: MWDevOtherAppsCell.reuseIdentifer(), for: indexPath) as? MWDevOtherAppsCell
        if cell == nil {
            cell = MWDevOtherAppsCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: MWDevOtherAppsCell.reuseIdentifer())
        }
        let type = dataList[indexPath.section]
        cell?.update(type.getAppImageName(), text: type.rawValue)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = dataList[indexPath.section]
        selectItemCallback?(type)
    }
    
}
