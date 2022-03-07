//
//  MeiJuDB.swift
//  meijuplay
//
//  Created by Horizon on 27/12/2021.
//

import Foundation

class MeiJuDB {
    
    /// 获取存储的列表数据
    class func getSavedListData(from type: String) -> MeiJuListResItem? {
        MWDataBase.shardDB.mw_create(table: kListCacheTableName, of: MeiJuListDBItem.self)
        let list: [MeiJuListDBItem] = MWDataBase.shardDB.mw_getObjects(fromTable: kListCacheTableName, where: MeiJuListDBItem.Properties.typeStr.in(type))
        
        var item: MeiJuListResItem?
        if let str = list.first?.jsonDataStr,
           let data = str.data(using: .utf8) {
            do {
                item = try JSONDecoder().decode(MeiJuListResItem.self, from: data)
            } catch {
                print(error)
            }
        }
        return item
    }
    
    /// 存储列表页第一页的数据
    class func saveListItemData(_ item: MeiJuListDBItem) {
        MWDataBase.shardDB.mw_create(table: kListCacheTableName, of: MeiJuListDBItem.self)
        MWDataBase.shardDB.mw_delete(fromTable: kListCacheTableName,
                                     where: MeiJuListDBItem.Properties.typeStr.in(item.typeStr),
                                     orderBy: nil, limit: nil, offset: nil)
        MWDataBase.shardDB.mw_insertOrReplace(objects: item, intoTable: kListCacheTableName)
    }
    
    
    /// 存储收藏
    class func saveFavoriteEpisode(item: MeiJuDBItem) {
        MWDataBase.shardDB.mw_create(table: kFavoriteTableName, of: MeiJuDBItem.self)
        MWDataBase.shardDB.mw_insertOrReplace(objects: item, intoTable: kFavoriteTableName)
    }
    
    /// 当前剧集是否收藏过
    class func isFavorite(_ itemId: String) -> Bool {
        if itemId.count == 0 {
            return false
        }
        MWDataBase.shardDB.mw_create(table: kFavoriteTableName, of: MeiJuDBItem.self)
        let list: [MeiJuDBItem] = MWDataBase.shardDB.mw_getObjects(fromTable: kFavoriteTableName, where: MeiJuDBItem.Properties.itemId.in(itemId))
        return list.count != 0
    }
    
    /// 删除收藏
    class func deleteFavoriteEpisode(_ itemId: String) {
        MWDataBase.shardDB.mw_create(table: kFavoriteTableName, of: MeiJuDBItem.self)
        MWDataBase.shardDB.mw_delete(fromTable: kFavoriteTableName,
                                     where: MeiJuDBItem.Properties.itemId.in(itemId),
                                     orderBy: nil, limit: nil, offset: nil)
    }
    
    /// 获取收藏的数据
    class func getFavoriteEpisodeList() -> [MeiJuDBItem]? {
        MWDataBase.shardDB.mw_create(table: kFavoriteTableName, of: MeiJuDBItem.self)
        // Sample.Properties.identifier.asOrder(by: .descending)
        let list: [MeiJuDBItem] = MWDataBase.shardDB.mw_getObjects(fromTable: kFavoriteTableName, orderBy: [MeiJuDBItem.Properties.lastInsertedRowID.asOrder(by: .descending)], limit: 6)
        return list
    }
    
    /// 存储最近播放
    class func saveRecentPlayEpisode(item: MeiJuDBItem) {
        MWDataBase.shardDB.mw_create(table: kRecentPlayTableName, of: MeiJuDBItem.self)
        MWDataBase.shardDB.mw_delete(fromTable: kFavoriteTableName,
                                     where: MeiJuDBItem.Properties.itemId.in(item.itemId),
                                     orderBy: nil, limit: nil, offset: nil)
        MWDataBase.shardDB.mw_insertOrReplace(objects: item, intoTable: kRecentPlayTableName)
    }
    
    /// 获取最近播放的数据
    class func getRecentPlayEpisodeList() -> [MeiJuDBItem]? {
        MWDataBase.shardDB.mw_create(table: kRecentPlayTableName, of: MeiJuDBItem.self)
        let list: [MeiJuDBItem] = MWDataBase.shardDB.mw_getObjects(fromTable: kRecentPlayTableName, orderBy: [MeiJuDBItem.Properties.lastInsertedRowID.asOrder(by: .descending)], limit: 6)
        return list
    }
    
    /// 保存当前播放的剧集以及进度
    class func save(item: MeiJuDBItem) {
        MWDataBase.shardDB.mw_create(table: EpisodeTableName, of: MeiJuDBItem.self)
        MWDataBase.shardDB.mw_insertOrReplace(objects: item, intoTable: EpisodeTableName)
    }
    
    /// 获取当前播放的剧集的历史记录
    class func getHistoryPlayEpisodeInfo(with itemId: String) -> MeiJuDBItem? {
        MWDataBase.shardDB.mw_create(table: EpisodeTableName, of: MeiJuDBItem.self)
        let list: [MeiJuDBItem] = MWDataBase.shardDB.mw_getObjects(fromTable: EpisodeTableName, where: MeiJuDBItem.Properties.itemId.in(itemId))
        return list.first
    }
    
    /// 删除当前播放的剧集的历史记录
    class func delegetPlayEpisodeInfo(with itemId: String) {
        MWDataBase.shardDB.mw_create(table: EpisodeTableName, of: MeiJuDBItem.self)
        MWDataBase.shardDB.mw_delete(fromTable: EpisodeTableName,
                                     where: MeiJuDBItem.Properties.itemId.in(itemId),
                                     orderBy: nil, limit: nil, offset: nil)
    }
}
