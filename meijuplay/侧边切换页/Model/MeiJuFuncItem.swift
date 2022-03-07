//
//  MeiJuFuncItem.swift
//  meijuplay
//
//  Created by Horizon on 21/12/2021.
//

import Foundation


enum FuncItemSelectType: Int {
    case select = 1 // 选中
    case jump // 跳转
}

enum FuncItemJumpType: String {
    case set = "set" // 设置
    case about = "about" // 关于
}

struct MeiJuFuncItem {
    var title: String?
    var selectType: FuncItemSelectType = .select
    var tagStr: String? // 标记字段；为 select 时是 typeStr；为 jump 时是自定义跳转区分的
}
