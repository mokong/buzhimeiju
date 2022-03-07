//
//  MWDataBase.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation
import WCDBSwift

/// 数据库
class MWDataBase {
    
    // MARK: - properties
    fileprivate var databasePath: String?
    fileprivate var db: Database?

    
    // MARK: - init
    static let shardDB = MWDataBase()
    fileprivate init() {
        databasePath = MWDataBase.getDBFilePath()
        reInitDb()
    }
    
    fileprivate func reInitDb() {
        if let dbStr = databasePath {
            db = Database(withPath: dbStr)
        }
        
        if db?.canOpen == true {
            print("数据库创建成功")
        }
        else {
            print("数据库创建失败")
        }
    }

    
    // MARK: - utils
    
    /// 创建表
    func mw_create<Root: TableDecodable>(table name: String, of rootType: Root.Type) {
        do {
            let isExist = try db?.isTableExists(name)
            if isExist != true {
                try db?.create(table: name, of: rootType)
            }
        } catch {
            print("创建表失败，表名：%@", name)
        }
    }
    
    /// 插入数据
    func mw_insertOrReplace<Object: TableEncodable>(objects: Object..., intoTable table: String) {
        do {
            try db?.insert(objects: objects, intoTable: table)
        } catch {
            print("插入数据失败")
        }
    }
    
    /// 查找数据
    func mw_getObjects<Object: TableDecodable>(fromTable table: String,
                                               where condition: Condition? = nil,
                                               orderBy orderList: [OrderBy]? = nil,
                                               limit: Limit? = nil,
                                               offset: Offset? = nil) -> [Object] {
        do {
            let list: [Object] = try db!.getObjects(fromTable: table,
                                               where: condition,
                                               orderBy: orderList,
                                               limit: limit,
                                               offset: offset)
            
            return list
        } catch {
            print("获取数据失败")
            return []
        }
    }
    
    /// 删除数据
    func mw_delete(fromTable table: String,
                   where condition: Condition?,
                   orderBy orderList: [OrderBy]?,
                   limit: Limit?,
                   offset: Offset?) {
        do {
            try db?.delete(fromTable: table,
                           where: condition,
                           orderBy: orderList,
                           limit: limit,
                           offset: offset)
        } catch {
            print("删除数据失败")
        }
    }
    
    // MARK: - action
    
    
    // MARK: - other
    static func getDBFilePath() -> String {
        if let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
            let dbPath = (path as NSString).appendingPathComponent("meiju.db")
            print("数据库路径：%@", dbPath)
            return dbPath
        }
        return ""
    }
    

    
}
