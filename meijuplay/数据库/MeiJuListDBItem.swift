//
//  MeiJuListDBItem.swift
//  meijuplay
//
//  Created by Horizon on 10/1/2022.
//

import Foundation
import WCDBSwift

class MeiJuListDBItem: TableCodable {
    var typeStr: String = "" // 列表类型
    var jsonDataStr: String? = nil // 数据jsonStr
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = MeiJuListDBItem
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case typeStr
        case jsonDataStr
    }
}
