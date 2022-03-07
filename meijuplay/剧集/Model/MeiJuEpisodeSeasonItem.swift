//
//  MeiJuEpisodeSeasonItem.swift
//  meijuplay
//
//  Created by Horizon on 22/12/2021.
//

import Foundation

struct MeiJuEpisodeSeasonItem: Decodable {
    var iid: String? // 8666
    var title: String? // 紧急呼救第五季
    var img: String? // https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2676879602.jpg
    var playtime: String? // 0
    var otitle: String? // 9-1-1 Season 5
    var jianjie: String? //
    var daoyan: String? //
    var zhuyan: String? //
    var list: [EpisodeSingleItem]? //
    
    enum CodingKeys: String, CodingKey {
        case iid
        case title
        case img
        case playtime
        case otitle
        case jianjie
        case daoyan
        case zhuyan
        case list
    }
}


struct EpisodeSingleItem: Decodable {
    var zhuti: String?
    var weburl: String? // http://jiexi.luomeidi.com/index.php/Index/json?vid=9d1f1f0c017c10000f0680b400000000",
    var bofang: String? // http://jiexi.luomeidi.com/index.php/Index/json?vid=9d1f1f0c017c10000f0680b400000000"
    
    enum CodingKeys: String, CodingKey {
        case zhuti
        case weburl
        case bofang
    }
}
