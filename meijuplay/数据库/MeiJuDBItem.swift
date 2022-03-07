//
//  MeiJuDBItem.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation
import WCDBSwift

class MeiJuDBItem: TableCodable {
    var title: String? // 标题
    var itemId: String = "" // id
    var episodeZhuTi: String? // 第几集
    var playDuration: String? // 播放时长
    var img: String? // 封面
    var bofang: String? // 播放地址
    
    var isAutoIncrement: Bool {
        return true
    } // 用于定义是否使用自增的方式插入
    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = MeiJuDBItem
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case title
        case itemId
        case episodeZhuTi
        case playDuration
        case img
        case bofang
        case lastInsertedRowID
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                title: ColumnConstraintBinding(isPrimary: false),
                itemId: ColumnConstraintBinding(isNotNull: true, defaultTo: ""),
                episodeZhuTi: ColumnConstraintBinding(isNotNull: false),
                playDuration: ColumnConstraintBinding(isNotNull: false),
                img: ColumnConstraintBinding(isNotNull: false),
                bofang: ColumnConstraintBinding(isNotNull: false),
                lastInsertedRowID: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true)
            ]
        }
    }
}
